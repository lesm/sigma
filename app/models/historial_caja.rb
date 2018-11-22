class HistorialCaja < ApplicationRecord
  belongs_to :caja
  belongs_to :cajero

  validates :caja_id, presence: true

  scope :last_historial_caja, -> (caja) { where(caja_id: caja.id).where(cajero_id: caja.cajero.id).where(fecha_cierre: nil).last }
end
