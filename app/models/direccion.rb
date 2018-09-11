class Direccion < ApplicationRecord
  belongs_to :contribuyente

  validates :calle, :colonia, :codigo_postal, :localidad,
    :municipio, :estado, :pais, presence: true

  def to_s
    "#{calle} ##{numero} #{colonia} #{codigo_postal} #{localidad} #{municipio} #{estado} #{pais}".upcase
  end


end
