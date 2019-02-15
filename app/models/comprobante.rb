class Comprobante < ApplicationRecord
  include AASM

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

  mount_uploader :xml, XmlUploader
  mount_uploader :cbb, CbbUploader
  mount_uploader :pdf, PdfUploader

  delegate :uuid, :no_certificado_sat, :no_certificado,
    :rfc_provedor_certificacion, :fecha_comprobante,
    :fecha_timbrado, :sello_sat, :sello_cfd, :cadena_original,
    to: :timbre, prefix: false, allow_nil: true

  aasm do
    state :sin_timbre, initial: true
    state :con_respuesta_valida, :procesando,
      :con_respuesta_invalida, :con_timbre,
      :con_xml, :con_cbb, :con_pdf

    event :continuar_timbrando do
      transitions from: :sin_timbre, to: :procesando, if: :con_peticion_valida?
      transitions from: :procesando, to: :con_respuesta_invalida, if: :respuesta_invalida?
      transitions from: :procesando, to: :con_respuesta_valida, if: :respuesta_valida?
      transitions from: :con_respuesta_valida, to: :con_timbre, if: :crea_timbre?
      transitions from: :con_timbre, to: :con_xml, if: :crea_xml?
      transitions from: :con_xml, to: :con_cbb, if: :crea_cbb?
      transitions from: :con_cbb, to: :con_pdf, if: :crea_pdf?
    end
  end

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

  def con_peticion_valida?
    respuesta_fm
  end

  def respuesta_invalida?
    !respuesta_valida?
  end

  def respuesta_valida?
    respuesta_fm.valid?
  end

  def crea_timbre?
    CreaTimbreDesdeRespuestaFm.new(self, respuesta_fm).crear
  end

  def crea_xml?
    CreaXmlDesdeRespuestaFm.new(self, respuesta_fm).crear
  end

  def crea_cbb?
    CreaCbbDesdeRespuestaFm.new(self, respuesta_fm).crear
  end

  def crea_pdf?
    self.pdf = pdf_file
    pdf_file.unlink
    save
  end

  def pdf_file
    @pdf_file ||= crea_pdf_file
  end

  def crea_pdf_file
    require "tempfile"

    Tempfile.open("pdf_file", Rails.root.join("tmp")) do |f|
      f.write(pdf_fm_encode)
      f.close
      f
    end
  end

  def pdf_fm_encode
    GenerarPdf.new.generar(self).force_encoding('utf-8').encode
  end

  def respuesta_fm
    @respuesta_fm ||= FmTimbradoCfdi.timbrar(emisor.rfc, fm_layout, 'generarCBB' => true)
  end

  def fm_layout
    FacturaLayout.new(ComprobanteLayoutPresenter.new(self)).to_s
  end

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
