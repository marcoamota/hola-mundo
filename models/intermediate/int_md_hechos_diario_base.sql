with params as (
    select
        max(case when cve_parametro = 'foliosplit' then to_number(valor_parametro) end) as folio_split_ini,
        max(case when cve_parametro = 'finfosplit' then to_number(valor_parametro) end) as folio_split_fin
    from {{ source('operaciones', 'CAT_PARAMETROS') }}
),
thechos as (
    select * from {{ ref('stg_thechos_mxd') }}
),
splits as (
    select * from {{ ref('stg_tsplits') }}
),
instrumentos as (
    select
        id_emision,
        id_tipo_valor,
        id_emisora,
        id_serie,
        tipo_instrumento
    from {{ source('historico', 'MD_CAT_INSTRUMENTOS') }}
),
tipos_valor as (
    select
        id_tipo_valor,
        id_tipo_inversion
    from {{ source('dwh', 'DWH_CAT_TIPOS_VALORES') }}
)
select
    trunc(sysdate) as id_fecha_hecho,
    case
        when nvl(sp.folio_split, 0) between p.folio_split_ini and p.folio_split_fin then sp.folio_split
        else th.folio
    end as id_folio,
    'MD' as id_mercado,
    tv.id_tipo_inversion as id_tipo_derivado,
    i.id_tipo_valor as tipo_valor,
    i.id_emisora as emisora,
    i.id_serie as serie,
    th.hora_hecho,
    th.hora_hecho as hora_hecho_segundo,
    th.hora_limite_confirmacion,
    nvl(sp.volumen_split, th.volumen) as volumen,
    th.precio,
    ((th.importe / nullif(th.volumen, 0)) * nvl(sp.volumen_split, th.volumen)) as importe,
    case
        when th.id_entidad_genero_hecho = th.id_entidad_vende and th.id_entidad_compra <> th.id_entidad_vende then 'VE'
        else 'CO'
    end as clave_orden,
    case when sp.confirmacion_compra = 0 then 'CA' else 'CI' end as tipo_confirmacion_compra,
    case when sp.confirmacion_vende = 0 then 'CA' else 'CI' end as tipo_confirmacion_vende,
    th.estado_monet,
    th.id_concertacion,
    th.id_entidad_vende,
    th.id_entidad_compra,
    th.id_cuenta_liquidador_venta,
    th.id_cuenta_liquidador_compra,
    th.id_hecho,
    th.id_num_instrumento as id_emision,
    i.tipo_instrumento,
    th.difundir_terminal_espera
from thechos th
left join splits sp
    on th.id_hecho = sp.id_hecho
join instrumentos i
    on th.id_num_instrumento = i.id_emision
join tipos_valor tv
    on i.id_tipo_valor = tv.id_tipo_valor
cross join params p
where nvl(sp.estado_hecho_negocio, 0) not in (4, 9, 14)
