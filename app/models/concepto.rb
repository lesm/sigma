class Concepto < ApplicationRecord
  CLAVE_PROD_SERV = {
    "93161700" => "93161700 - Administración tributaria",
    "93171500" => "93171500 - Política comercial",
    "93151500" => "93151500 - Administración pública"
  }
  CLAVE_UNIDAD = { "E48" => "E48 - Unidad de servicio" }

  belongs_to :cuenta
  belongs_to :comprobante
  has_one :datos_concepto, dependent: :destroy
  accepts_nested_attributes_for :datos_concepto, allow_destroy: true

  validates :importe, :cantidad, :valor_unitario, :clave, :clave_unidad,
    presence: true
  validates :cantidad, numericality: { greater_than: 0 }
  validate :importe_value

  scope :by_range_of_dates, -> (range_of_dates) { includes(:comprobante).where(comprobantes: { created_at: range_of_dates }) }

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
    if importe != importe_redondeado
      errors.add :importe, "debe ser #{cantidad_por_valor_unitario}"
    end
  end

  private

  def importe_redondeado
    return cantidad_por_valor_unitario if [0, 50].include?(centavos)
    cantidad_por_valor_unitario - centavos_redondeados
  end

  def centavos_redondeados
    return redondear(centavos - 50) if (centavos >= 51)
    redondear
  end

  def redondear cantidad = centavos
    return "0.#{cantidad}".to_f if (cantidad >= 10)
    "0.0#{cantidad}".to_f
  end

  def centavos
    ('%02d' % ((cantidad_por_valor_unitario * 100).to_i % 100)).to_i
  end

  def cantidad_por_valor_unitario
    cantidad * valor_unitario
  end
end
