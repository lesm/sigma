class Direccion < ApplicationRecord
  belongs_to :contribuyente

  validates :calle, :colonia, :codigo_postal, :localidad,
    :municipio, :estado, :pais, presence: true
end
