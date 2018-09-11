class Contribuyente < ApplicationRecord
  has_one :direccion, dependent: :destroy
  accepts_nested_attributes_for :direccion

  validates :nombre_o_razon_social, presence: true
  validates :primer_apellido, presence: true, if: :persona_fisica?
  validates :rfc, length: { is: 13 }, if: :persona_fisica_con_rfc?
  validates :rfc, length: { is: 12 }, if: :persona_moral_con_rfc?
  validates :rfc, rfc_format: { force_homoclave: true }, allow_blank: true

  def nombre_completo
    "#{nombre_o_razon_social} #{primer_apellido} #{segundo_apellido}".strip.titleize
  end

  def to_s
    "#{nombre_completo} - #{rfc}"
  end

  def tipo
    persona_fisica? ? "Persona Física" : "Persona Moral"
  end

  private

  def persona_fisica_con_rfc?
    rfc.present? && persona_fisica?
  end

  def persona_moral_con_rfc?
    rfc.present? && persona_fisica == false
  end
end
