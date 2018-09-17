class Emisor < ApplicationRecord
  include Direccionable

  validates :nombre, :rfc, :regimen_fiscal, presence: true
  validates :rfc, length: { is: 12 }

  def nombre_con_rfc
    "#{nombre} - #{rfc}"
  end
end
