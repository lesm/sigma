FactoryBot.define do
  factory :cajero do
    nombre { "Pedro" }
    sequence(:username) { |n| "pedrito#{n}" }
    activo { true }
    password { "1qaz2wsx" }
    rol { 1 }
    caja
  end

  trait :con_contribuyente do
    after :build do |cajero|
      cajero.contribuyente = build :contribuyente, :con_direccion
    end
  end
end
