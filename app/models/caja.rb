class Caja < ApplicationRecord
  belongs_to :cajero, optional: true
  has_many :comprobantes
  validates :nombre, :numero, presence: true
  validates :nombre, :numero, uniqueness: true
  validates :numero, numericality: { greater_than_or_equal_to: 1 }

  scope :disponibles, -> { where(disponible: true) }
  scope :no_disponibles, -> { where(disponible: false) }

  def self.disponibles?
    Caja.disponibles.count > 0
  end

  def cerrar!(cajero_id)
    update_columns(cajero_id: cajero_id, disponible: false)
  end

  def abrir!
    #TODO implement transations
    update_historial_caja!
    Caja.find(id).update_columns(cajero_id: nil, disponible: true)
  end

  def update_historial_caja!
    last_historial_caja.update_column(:fecha_cierre, Date.current)
  end

  def to_s
    "#{nombre.to_s.capitalize} - #{numero}"
  end

  private

  def last_historial_caja
    HistorialCaja.last_historial_caja(self)
  end
end
