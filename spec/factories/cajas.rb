FactoryBot.define do
  factory :caja do
    nombre { "Caja principal" }
    descripcion { "La que está en el municipio" }
    disponible { true }
  end
end
