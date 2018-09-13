class CierreCaja < ApplicationRecord
  belongs_to :usuario
  has_many :arqueos, inverse_of: :cierre_caja

  validates :monto, presence: true
  before_save :update_monto

  def update_monto
    self.monto = arqueos.map(&:monto).reduce(:+)
  end
end
