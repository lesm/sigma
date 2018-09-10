FactoryBot.define do
  factory :contribuyente do
    nombre_o_razon_social "Pedro"
    primer_apellido "Perez"
    segundo_apellido "Perez"
    persona_fisica true
    email "pedro@gmail.com"
    rfc "AAAA111111AAA"
  end
end
