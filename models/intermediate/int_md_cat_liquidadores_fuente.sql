select
  cuenta_liquidadora as id_clave_liquidador,
  descripcion as liquidador,
  decode(es_giveup, 1, 'SI', 'NO') as ind_opera_giveup,
  id_cuenta_liquidadora
from {{ ref('stg_ope_tcuentas_liquidaciones') }}
