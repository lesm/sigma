class Cuenta < ApplicationRecord
  has_many :conceptos

  validates :codigo, :descripcion, presence: true
  validates :codigo, length: { is: 6 }
  validates :descripcion, uniqueness: { case_sensitive: false }

  def self.search search
    where("concat_ws(' ', codigo, descripcion) ILIKE ?", "%#{search&.squish}%")
  end

  def to_s
    "#{codigo} - #{formato} - #{descripcion}"
  end
end
