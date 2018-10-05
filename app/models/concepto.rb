class Concepto < ApplicationRecord
  belongs_to :cuenta
  validates :importe, presence: true
end
