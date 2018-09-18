class CierreCaja < ApplicationRecord
  belongs_to :usuario
  has_many :arqueos, inverse_of: :cierre_caja, dependent: :destroy

  validates :monto_sistema, :monto_cajero, presence: true

  def update_monto_cajero
    self.monto_cajero = arqueos.map(&:monto_cajero).reduce(:+)
    save!
  end
end
