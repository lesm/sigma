class Cuenta < ApplicationRecord
  has_many :conceptos
  has_and_belongs_to_many :contribuyentes, -> { distinct }

  validates :codigo, :descripcion, :clave_producto, :clave_unidad,
    presence: true
  validates :codigo, length: { is: 6 }
  validates :descripcion, uniqueness: { case_sensitive: false }

  def self.search search
    where("descripcion ILIKE ?", "%#{search&.squish}%")
  end

  def to_s
    descripcion
  end
end
