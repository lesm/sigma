FactoryBot.define do
  factory :contribuyente do
    nombre_o_razon_social { "Pedro" }
    primer_apellido { "Perez" }
    segundo_apellido { "Perez" }
    persona_fisica { true }
    email { "pedro@gmail.com" }
    rfc { "AAAA111111AAA" }

    trait :con_direccion do
      before(:create) do |contribuyente|
        contribuyente.direccion = build :direccion
      end
    end
  end
end
