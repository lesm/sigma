class Concepto < ApplicationRecord
  belongs_to :cuenta
  has_one :datos_concepto, dependent: :destroy
  accepts_nested_attributes_for :datos_concepto, allow_destroy: true

  validates :importe, presence: true

  delegate :folio, :clave_catastral, :numero_cuenta, :ubicacion,
    :base_catastral, :impuesto_predial, :observaciones, :fecha,
    :serie, :placa, :estimacion, :nombre_obra, :localidad,
    :nombre_contratista, :fecha_refrendo, :cantidad_folios_cinco,
    :cantidad_folios_diez, :resposable, :mes_pago, :fecha_corte,
    :numero_contrato, :numero_medidor, :lectura_actual,
    :lectura_anterior, :consumo, :ruta, :lecturista,
    to: :datos_concepto, prefix: false, allow_nil: true
end
