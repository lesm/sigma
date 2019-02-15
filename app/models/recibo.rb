class Recibo < Comprobante
  attr_accessor :cuenta_ids

  belongs_to :factura_global, optional: true
end
