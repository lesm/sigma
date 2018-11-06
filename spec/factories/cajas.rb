FactoryBot.define do
  factory :caja do
    sequence(:nombre) { |n| "Caja principal#{n}" }
    descripcion { "La que está en el municipio" }
    disponible { true }
  end
end
