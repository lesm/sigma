class Comprobante < ApplicationRecord
  FORMA_PAGO = {
    "01" => "01 - Efectivo",
    "02" => "02 - Cheque nominativo",
    "03" => "03 - Transferencia electrónica de fondos",
    "04" => "04 - Tarjeta de crédito",
    "28" => "28 - Tarjeta de débito",
  }

  USO_CFDI = {
    "G03" => "G03 - Gastos en general",
    "D03" => "D03 - Gastos funerales",
    "D04" => "D04 - Donativos",
    "P01" => "P01 - Por definir"
  }

  attr_accessor :timbrado_automatico

  belongs_to :caja
  belongs_to :contribuyente
  belongs_to :emisor
  belongs_to :cajero
  belongs_to :arqueo, optional: true
  has_one :timbre
  has_many :conceptos, dependent: :destroy
  accepts_nested_attributes_for :conceptos

  validates :folio, :moneda, :tipo_comprobante, :lugar_expedicion,
    :fecha_emision, :metodo_pago, :forma_pago, :subtotal, :descuento,
    :total, presence: true
  validates :total, :subtotal, numericality: { greater_than: 0 }
  validates :uso_cfdi, presence: true, if: :timbrado_automatico?
  validate :valida_subtotal
  validate :valida_total

  scope :sin_arqueo,            -> { where(arqueo_id: nil) }
  scope :del_dia,               -> { where(created_at: self.rango_fecha) }
  scope :para_arqueo_actual,    -> (cajero) { sin_arqueo.where(caja_id: cajero.caja.id, cajero_id: cajero.id).del_dia }
  scope :monto_cheque,          -> (cajero) { para_arqueo_actual(cajero).de_cheque.sum(:total) }
  scope :monto_efectivo,        -> (cajero) { para_arqueo_actual(cajero).de_efectivo.sum(:total) }
  scope :monto_transferencia,   -> (cajero) { para_arqueo_actual(cajero).de_transferencia.sum(:total) }
  scope :monto_tarjeta_credito, -> (cajero) { para_arqueo_actual(cajero).de_credito.sum(:total) }
  scope :monto_tarjeta_debito,  -> (cajero) { para_arqueo_actual(cajero).de_debito.sum(:total) }

  scope :monto_no_efectivo, -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: self.formas_pago_no_efectivo ).sum(:total) }
  scope :monto_total,       -> (cajero) { para_arqueo_actual(cajero).where(forma_pago: FORMA_PAGO.values).sum(:total) }

  scope :de_efectivo,      -> { where(forma_pago: "01 - Efectivo") }
  scope :de_cheque,        -> { where(forma_pago: "02 - Cheque nominativo") }
  scope :de_transferencia, -> { where(forma_pago: "03 - Transferencia electrónica de fondos") }
  scope :de_credito,       -> { where(forma_pago: "04 - Tarjeta de crédito") }
  scope :de_debito,        -> { where(forma_pago: "28 - Tarjeta de débito") }

  def timbrado_automatico?
    ActiveModel::Type::Boolean.new.cast(timbrado_automatico)
  end

  def self.total_monto_sistema(cajero)
    Comprobante.para_arqueo_actual(cajero).sum(:total)
  end

  def centavos
    '%02d' % ((total * 100).to_i % 100)
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
    FORMA_PAGO.values - ["01 - Efectivo"]
  end
end
