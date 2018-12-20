FactoryBot.define do
  factory :usuario do
    nombre { "Pedro" }
    sequence(:username) { |n| "pedrito#{n}" }
    activo { true }
    password { "1qaz2wsx" }
    rol { 0 }
  end

  trait :super_user do
    after(:build) do |usuario|
      usuario.username = "super_user"
      usuario.rol = 4
    end
  end
end
