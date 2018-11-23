FactoryBot.define do
  factory :cuenta do
    codigo { "110101" }
    sequence(:descripcion) { |n| "RIFAS#{n}" }
    formato { "DatosComun" }
  end
end
