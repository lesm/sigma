class HistorialCaja < ApplicationRecord
  belongs_to :caja
  belongs_to :cajero

  validates :caja_id, presence: true
end
