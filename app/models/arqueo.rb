class Arqueo < ApplicationRecord
  belongs_to :cierre_caja, inverse_of: :arqueos
  validates :monto, presence: true
  validates :monto, numericality: { greater_than: 0 }
  after_save :update_monto_cierre_caja

  def update_monto_cierre_caja
    cierre_caja.update_monto
  end
end
