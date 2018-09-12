class Emisor < ApplicationRecord
  include Direccionable

  validates :nombre, :rfc, :regimen_fiscal,
    :registro_patronal, :lugar_expedicion, presence: true
  validates :rfc, length: { is: 12 }
end
