select
  id_casa_bolsa,
  clave_casa_bolsa
from {{ source('dwh', 'D_CASAS_BOLSA') }}
