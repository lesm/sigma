class Recibo < Comprobante
  attr_accessor :cuenta_ids

  belongs_to :factura_global, optional: true

  scope :sin_factura_global, -> { where(factura_global_id: nil) }
end
