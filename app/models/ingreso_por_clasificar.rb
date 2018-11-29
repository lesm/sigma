class IngresoPorClasificar < ApplicationRecord
  belongs_to :cajero
  belongs_to :arqueo

  validates :monto, presence: true
end
