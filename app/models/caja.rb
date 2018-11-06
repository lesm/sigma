class Caja < ApplicationRecord
  belongs_to :cajero, optional: true
  validates :nombre, :numero, presence: true
  validates :nombre, :numero, uniqueness: true
  validates :numero, numericality: { greater_than_or_equal_to: 1 }

  def self.cajas_disponibles?
    Caja.where(disponible: true).count > 0
  end

  def cerrar!(cajero_id)
    update_columns(cajero_id: cajero_id, disponible: false)
  end

  def abrir!
    Caja.find(id).update_columns(cajero_id: nil, disponible: true)
  end

  def to_s
    nombre.capitalize
  end
end
