class Arqueo < ApplicationRecord
  belongs_to :cierre_caja, inverse_of: :arqueos
  validates :monto_sistema, :monto_cajero, presence: true
  validates :monto_sistema, :monto_cajero, numericality: { greater_than: 0 }
  after_save :update_monto_cajero_cierre_caja

  def update_monto_cajero_cierre_caja
    cierre_caja.update_monto_cajero
  end

  def monto_sistema
    9.99
  end
end
