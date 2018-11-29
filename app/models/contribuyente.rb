class Contribuyente < ApplicationRecord
  USO_CFDI = {
    'P01' => "Por definir"
  }

  include Direccionable
  has_many :facturas
  has_many :recibos

  has_one :cajero
  validates :nombre_o_razon_social, presence: true
  validates :primer_apellido, presence: true, if: :persona_fisica?
  validates :rfc, length: { is: 13 }, if: :persona_fisica_con_rfc?
  validates :rfc, length: { is: 12 }, if: :persona_moral_con_rfc?
  validates :rfc, rfc_format: { force_homoclave: true }, allow_blank: true
  validates :rfc, uniqueness: true, unless: :rfc_generico?, allow_blank: true

  def nombre_completo
    "#{nombre_o_razon_social} #{primer_apellido} #{segundo_apellido}".strip.titleize
  end

  def to_s
    rfc.present? ? "#{nombre_completo} - #{rfc}" : nombre_completo
  end

  def tipo
    persona_fisica? ? "Persona Física" : "Persona Moral"
  end

  private

  def rfc_generico?
    rfc == "XAXX010101000"
  end

  def persona_fisica_con_rfc?
    rfc.present? && persona_fisica?
  end

  def persona_moral_con_rfc?
    rfc.present? && persona_fisica == false
  end
end
