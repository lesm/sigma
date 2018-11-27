class CierreCaja < ApplicationRecord
  belongs_to :cajero
  has_many :arqueos, inverse_of: :cierre_caja, dependent: :destroy

  validates :monto_sistema, :monto_cajero, :cajero, presence: true

  def update_montos
    update_monto_cajero
    update_monto_sistema
    save!
  end

  private

  def update_monto_cajero
    self.monto_cajero = arqueos.reload.map(&:monto_cajero).reduce(:+)
  end

  def update_monto_sistema
    self.monto_sistema = arqueos.reload.map(&:monto_sistema).reduce(:+)
  end
end
