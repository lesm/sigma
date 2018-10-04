class Comprobante < ApplicationRecord
  belongs_to :contribuyente
  belongs_to :emisor
  belongs_to :cajero
  belongs_to :arqueo

  validates :folio, :moneda, :tipo_comprobante, :lugar_expedicion,
    :metodo_pago, :forma_pago, :subtotal, :descuento, :total, presence: true
end
