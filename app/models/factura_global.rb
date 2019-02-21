class FacturaGlobal < Comprobante
  attr_accessor :fecha_inicio, :fecha_fin

  has_many :recibos
end
