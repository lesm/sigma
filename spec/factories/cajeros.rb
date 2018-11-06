FactoryBot.define do
  factory :cajero do
    nombre { "Pedro" }
    sequence(:username) { |n| "pedrito#{n}" }
    activo { true }
    password { "1qaz2wsx" }
    rol { 1 }
    caja
  end
end
