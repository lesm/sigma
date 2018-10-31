class Caja < ApplicationRecord
  belongs_to :cajero, optional: true
  validates :nombre, presence: true
  validates :nombre, uniqueness: true

  def self.cajas_disponibles?
    Caja.where(disponible: true).count > 0
  end

  def cerrar!(cajero_id)
    update_columns(cajero_id: cajero_id, disponible: false)
  end

  def abrir!
    update_columns(cajero_id: nil, disponible: true)
    reload
  end

  def to_s
    nombre.capitalize
  end
end
