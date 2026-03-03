select
  id_idconcertacion,
  id_concertacion
from {{ source('dwh', 'DWH_CAT_TIPO_CONCERTACION') }}
