class Concepto < ApplicationRecord
  belongs_to :cuenta
  belongs_to :comprobante
  has_one :datos_concepto, dependent: :destroy
  accepts_nested_attributes_for :datos_concepto, allow_destroy: true

  validates :importe, :cantidad, :valor_unitario, presence: true
  validates :cantidad, numericality: { only_integer: true }
  validate :importe_value

  delegate :folio, :clave_catastral, :numero_cuenta, :ubicacion,
    :base_catastral, :impuesto_predial, :observaciones, :fecha,
    :serie, :placa, :estimacion, :nombre_obra, :localidad,
    :nombre_contratista, :fecha_refrendo, :cantidad_folios_cinco,
    :cantidad_folios_diez, :resposable, :mes_pago, :fecha_corte,
    :numero_contrato, :numero_medidor, :lectura_actual,
    :lectura_anterior, :consumo, :ruta, :lecturista, :years,
    to: :datos_concepto, prefix: false, allow_nil: true

  def importe_value
    return if cantidad.nil? or valor_unitario.nil?
    resultado = cantidad * valor_unitario
    if importe != resultado
      errors.add :importe, "debe ser #{resultado}"
    end
  end
end
