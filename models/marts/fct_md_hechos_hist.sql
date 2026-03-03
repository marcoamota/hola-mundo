select
  *
from {{ ref('int_md_hechos_diario_base') }}
where estado_monet not in (0, 3)
  and tipo_instrumento = 1
  and difundir_terminal_espera = 0
