class HistorialCaja < ApplicationRecord
  belongs_to :caja
  belongs_to :cajero
end
