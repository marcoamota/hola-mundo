select
  id_cuenta_liquidadora,
  cuenta_liquidadora,
  descripcion,
  es_giveup
from {{ source('operaciones', 'OPE_TCUENTAS_LIQUIDACIONES') }}
