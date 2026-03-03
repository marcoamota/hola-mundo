select
  *
from {{ ref('int_md_hechos_diario_enriquecido') }}
where estado_monet in (0, 3)
