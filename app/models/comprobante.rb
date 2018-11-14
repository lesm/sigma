class Comprobante < ApplicationRecord
  attr_accessor :timbrado_automatico
  belongs_to :caja

  validate :valida_subtotal
  validate :valida_total

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

  private

  def valida_total
    if total_diferente_suma_importe_conceptos?
      errors.add :total, "debe ser igual a la suma del importe de los conceptos"
    end
  end

  def valida_subtotal
    if subtotal_diferente_total?
      errors.add :subtotal, "debe ser igual a total"
    end
  end

  def suma_importe_conceptos
    conceptos.map(&:importe).reduce(:+)
  end

  def subtotal_diferente_total?
    subtotal != total
  end

  def total_diferente_suma_importe_conceptos?
    total != suma_importe_conceptos
  end
end
