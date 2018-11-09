class Comprobante < ApplicationRecord
  attr_accessor :timbrado_automatico
  belongs_to :caja

  FORMA_PAGO = {
    "01" => "Efectivo",
    "02" => "Cheque nominativo",
    "03" => "Transferencia electrónica de fondos",
    "04" => "Tarjeta de crédito",
    "28" => "Tarjeta de débito",
  }

  belongs_to :contribuyente
  belongs_to :emisor
  belongs_to :cajero
  belongs_to :arqueo, optional: true
  has_many :conceptos, dependent: :destroy
  accepts_nested_attributes_for :conceptos

  validates :folio, :moneda, :tipo_comprobante, :lugar_expedicion,
    :fecha_emision, :metodo_pago, :forma_pago, :subtotal, :descuento,
    :total, presence: true
  validates :total, :subtotal, numericality: { greater_than: 0 }


  def timbrado_automatico?
    ActiveModel::Type::Boolean.new.cast(timbrado_automatico)
  end
end
