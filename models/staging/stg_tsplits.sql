select
  id_split,
  id_hecho,
  folio_split,
  volumen as volumen_split,
  posicion_venta,
  posicion_compra,
  es_automatico,
  cve_cuenta_vendedor,
  cve_cuenta_comprador,
  subcuenta_venta,
  subcuenta_compra,
  confirmacion_vende,
  confirmacion_compra,
  receptor_venta,
  receptor_compra,
  estado_hecho_negocio
from {{ source('stage', 'STG_TSPLITS') }}
