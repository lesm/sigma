class Direccion < ApplicationRecord
  validates :calle, :colonia, :codigo_postal, :localidad,
   :municipio, :estado, :pais, presence: true
end
