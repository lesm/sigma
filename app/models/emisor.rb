class Emisor < ApplicationRecord
  include Direccionable
  has_many :recibos
  has_many :facturas

  validates :nombre, :numero_municipio, :rfc, :regimen_fiscal,
    :logotipo, :escudo, presence: true
  validates :numero_municipio, uniqueness: true
  validates :numero_municipio, format: { with: /\A\d+\z/ }
  validates :rfc, length: { is: 12 }

  delegate :codigo_postal, to: :direccion, prefix: false,
    allow_nil: true

  mount_uploader :logotipo, LogotipoUploader
  mount_uploader :escudo, EscudoUploader

  def logotipo_small_url
    logotipo.small.url
  end

  def escudo_small_url
    escudo.small.url
  end

  def logotipo_medium_url
    logotipo.medium.url
  end

  def escudo_medium_url
    escudo.medium.url
  end

  def nombre_con_rfc
    "#{nombre} - #{rfc}"
  end
end
