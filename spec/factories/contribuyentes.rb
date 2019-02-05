FactoryBot.define do
  factory :contribuyente do
    nombre_o_razon_social { "Pedro" }
    primer_apellido { "Perez" }
    segundo_apellido { "Perez" }
    persona_fisica { true }
    rfc { "AAA#{FactoryBotHelpers.random_values_rfc}" }
    email { "pedro@gmail.com" }
    concepto_ids { [1,2] }

    trait :con_direccion do
      after(:build) do |contribuyente|
        contribuyente.direccion = build :direccion
      end
    end

    trait :persona_moral do
      after(:build) do |contribuyente|
        contribuyente.persona_fisica        = false
        contribuyente.nombre_o_razon_social = "Mi Empresa"
        contribuyente.primer_apellido       = nil
        contribuyente.segundo_apellido      = nil
        contribuyente.rfc                   = "AA#{FactoryBotHelpers.random_values_rfc}"
      end
    end
  end
end
