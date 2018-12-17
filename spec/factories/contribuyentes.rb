FactoryBot.define do
  factory :contribuyente do
    nombre_o_razon_social { "Pedro" }
    primer_apellido { "Perez" }
    segundo_apellido { "Perez" }
    persona_fisica { true }
    email { "pedro@gmail.com" }
    concepto_ids { [1,2] }
    sequence(:rfc) { |n| "AAA#{('A'..'Z').to_a.sample}#{'%02d'%(1..99).to_a.sample}#{'%02d'%(1..12).to_a.sample}#{'%02d'%(1..27).to_a.sample}A#{('A'..'Z').to_a.sample}A" }

    trait :con_direccion do
      before(:create) do |contribuyente|
        contribuyente.direccion = build :direccion
      end
    end
  end
end
