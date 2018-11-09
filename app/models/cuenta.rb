class Cuenta < ApplicationRecord
  has_many :conceptos

  validates :codigo, :descripcion, presence: true
  validates :codigo, length: { is: 6 }
  validates :descripcion, uniqueness: { case_sensitive: false }

  def to_s
    "#{codigo} - #{formato} - #{descripcion}"
  end
end
