class CierreCaja < ApplicationRecord
  belongs_to :usuario

  validates :monto, presence: true

end
