class Emisor < ApplicationRecord
  include Direccionable

  validates :nombre, :rfc, :regimen_fiscal,
    :registro_patronal, presence: true
  validates :rfc, length: { is: 12 }

  def nombre_con_rfc
    "#{nombre} - #{rfc}"
  end
end
