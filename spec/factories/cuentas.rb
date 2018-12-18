FactoryBot.define do
  factory :cuenta do
    codigo { "110101" }
    sequence(:descripcion) { |n| "RIFAS#{n}" }
    formato { "DatosComun" }

    trait :rifas do
      after :build do |cuenta|
        cuenta.codigo = "110101"
        cuenta.descripcion = "RIFAS"
        cuenta.formato = "DatosComun"
      end
    end

    trait :sorteos do
      after :build do |cuenta|
        cuenta.codigo = "110102"
        cuenta.descripcion = "SORTEOS"
        cuenta.formato = "DatosComun"
      end
    end

    trait :loterias do
      after :build do |cuenta|
        cuenta.codigo = "110103"
        cuenta.descripcion = "LOTERÍAS"
        cuenta.formato = "DatosComun"
      end
    end

    trait :teatros do
      after :build do |cuenta|
        cuenta.codigo = "110201"
        cuenta.descripcion = "TEATROS"
        cuenta.formato = "DatosComun"
      end
    end
  end
end
