class CierreCaja < ApplicationRecord
  belongs_to :usuario
  has_many :arqueos, inverse_of: :cierre_caja, dependent: :destroy

  validates :monto, presence: true

  def update_monto
    self.monto = arqueos.map(&:monto).reduce(:+)
    save!
  end
end
