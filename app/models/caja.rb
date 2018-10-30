class Caja < ApplicationRecord
  validates :nombre, presence: true
  validates :nombre, uniqueness: true

  def self.cajas_disponibles?
    Caja.where(disponible: true).count > 0
  end
end
