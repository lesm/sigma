class Cuenta < ApplicationRecord
  validates :codigo, :descripcion, presence: true
  validates :codigo, length: { is: 6 }
  validates :codigo, uniqueness: true
end
