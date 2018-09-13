class Arqueo < ApplicationRecord
  belongs_to :cierre_caja, inverse_of: :arqueos
  validates :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
end
