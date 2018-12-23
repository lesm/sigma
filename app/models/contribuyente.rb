class Contribuyente < ApplicationRecord
  USO_CFDI = {
    'P01' => "Por definir"
  }

  VALID_LENGTH_RFC_WITHOUT_HOMOCLAVE_PERSONA_FISICA = 10.freeze
  VALID_LENGTH_RFC_SAT_PERSONA_FISICA               = 13.freeze
  VALID_LENGTH_RFC_SAT_PERSONA_MORAL                = 12.freeze

  VALID_LENGTHS_RFC_PERSONA_FISICA = [
    VALID_LENGTH_RFC_WITHOUT_HOMOCLAVE_PERSONA_FISICA,
    VALID_LENGTH_RFC_SAT_PERSONA_FISICA
  ].freeze

  include Direccionable
  has_one :cajero
  has_many :facturas
  has_many :recibos
  has_and_belongs_to_many :cuentas, -> { distinct }

  validates :nombre_o_razon_social, presence: true
  validates :concepto_ids, presence: true, on: :create
  validates :rfc, uniqueness: true, unless: :rfc_generico?, allow_blank: true
  validates :rfc, rfc_format: { force_homoclave: true }, if: :rfc_present_and_rfc_is_not_10_digits_length?

  #persona_fisica
  validates :primer_apellido, presence: true, if: :persona_fisica?
  validate :rfc, :validate_length, if: :persona_fisica_con_rfc?
  validates :rfc, rfc_format: { force_homoclave: false }, if: :valid_length_rfc_without_homoclave_persona_fisica?

  #persona_moral
  validates :rfc, length: { is: VALID_LENGTH_RFC_SAT_PERSONA_MORAL }, if: :persona_moral_con_rfc?

  attr_accessor :concepto_ids

  def self.search search
    where("concat_ws(' ', nombre_o_razon_social, primer_apellido, segundo_apellido, rfc) ILIKE ?", "%#{search&.squish}%")
  end

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

  def validate_length
    if length_rfc_persona_fisica_invalid?
      errors.add :rfc, "debe ser de 10 o 13 caracteres"
    end
  end

  def length_rfc_persona_fisica_invalid?
    VALID_LENGTHS_RFC_PERSONA_FISICA.exclude?(rfc.length)
  end

  def rfc_present_and_rfc_is_not_10_digits_length?
    rfc.present? and !valid_length_rfc_without_homoclave_persona_fisica?
  end

  def valid_length_rfc_without_homoclave_persona_fisica?
    return false unless persona_fisica_con_rfc?
    VALID_LENGTH_RFC_WITHOUT_HOMOCLAVE_PERSONA_FISICA == rfc.length
  end

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
