class Emisor < ApplicationRecord
  include Direccionable
  has_many :recibos
  has_many :facturas

  validates :nombre, :rfc, :regimen_fiscal, presence: true
  validates :rfc, length: { is: 12 }

  mount_uploader :logotipo, LogotipoUploader
  mount_uploader :escudo, EscudoUploader

  def nombre_con_rfc
    "#{nombre} - #{rfc}"
  end
end
