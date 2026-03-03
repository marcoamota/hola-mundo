select
  id_emisora,
  emisora
from {{ source('stage', 'STG_MXD_EMISORAS') }}
