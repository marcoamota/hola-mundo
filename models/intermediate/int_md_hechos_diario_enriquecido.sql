with base as (
    select * from {{ ref('int_md_hechos_diario_base') }}
),
instrumentos_monet as (
    select
        id_emision,
        id_emisora_monet
    from {{ source('historico', 'MD_CAT_INSTRUMENTOS') }}
),
emisoras as (
    select * from {{ ref('stg_mxd_emisoras') }}
),
concertacion as (
    select * from {{ ref('stg_cat_tipo_concertacion') }}
),
casas_bolsa as (
    select * from {{ ref('stg_casas_bolsa') }}
),
liquidadores as (
    select * from {{ ref('stg_md_cat_liquidadores') }}
)
select
    b.*,
    trim(em.emisora) as emisora_real,
    con.id_concertacion as concertacion,
    cbv.clave_casa_bolsa as clave_vendedor,
    cbc.clave_casa_bolsa as clave_comprador,
    lqv.id_clave_liquidador as socio_liquidador_venta,
    lqc.id_clave_liquidador as socio_liquidador_compra,
    'CO' as estado,
    cbv.clave_casa_bolsa as clave_vendedor_real,
    cbc.clave_casa_bolsa as clave_comprador_real
from base b
left join instrumentos_monet im
    on b.id_emision = im.id_emision
left join emisoras em
    on im.id_emisora_monet = em.id_emisora
left join concertacion con
    on b.id_concertacion = con.id_idconcertacion
left join casas_bolsa cbv
    on b.id_entidad_vende = cbv.id_casa_bolsa
left join casas_bolsa cbc
    on b.id_entidad_compra = cbc.id_casa_bolsa
left join liquidadores lqv
    on b.id_cuenta_liquidador_venta = lqv.id_cuenta_liquidadora
left join liquidadores lqc
    on b.id_cuenta_liquidador_compra = lqc.id_cuenta_liquidadora
