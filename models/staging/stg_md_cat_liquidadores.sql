select
  id_cuenta_liquidadora,
  id_clave_liquidador
from {{ source('historico', 'MD_CAT_LIQUIDADORES') }}
