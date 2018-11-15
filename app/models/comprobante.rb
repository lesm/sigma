class Comprobante < ApplicationRecord
  FORMA_PAGO = {
    "01" => "Efectivo",
    "02" => "Cheque nominativo",
    "03" => "Transferencia electrónica de fondos",
    "04" => "Tarjeta de crédito",
    "28" => "Tarjeta de débito",
  }

  attr_accessor :timbrado_automatico

  belongs_to :caja
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
  validate :valida_subtotal
  validate :valida_total

  scope :sin_arqueo, -> { where(arqueo_id: nil) }
  scope :del_dia, -> { where(created_at: self.rango_fecha) }
  scope :para_arqueo_actual, -> (cajero) { sin_arqueo.where(caja_id: cajero.caja.id, cajero_id: cajero.id).del_dia }
  scope :monto_cheque, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: "Cheque nominativo").sum(:total) }
  scope :monto_efectivo, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: "Efectivo").sum(:total) }
  scope :monto_transferencia, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: "Transferencia electrónica de fondos").sum(:total) }
  scope :monto_tarjeta_credito, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: "Tarjeta de crédito").sum(:total) }
  scope :monto_tarjeta_debito, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: "Tarjeta de débito").sum(:total) }

  scope :monto_no_efectivo, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: self.formas_pago_no_efectivo ).sum(:total) }
  scope :monto_total, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: FORMA_PAGO.values).sum(:total) }

  def timbrado_automatico?
    ActiveModel::Type::Boolean.new.cast(timbrado_automatico)
  end

  def self.total_monto_sistema(cajero)
    Comprobante.para_arqueo_actual(cajero).sum(:total)
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

  def self.rango_fecha
    Date.current.beginning_of_day..Date.current.end_of_day
  end

  def self.formas_pago_no_efectivo
    FORMA_PAGO.values - ["Efectivo"]
  end
end
