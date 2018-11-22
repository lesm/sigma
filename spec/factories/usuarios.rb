FactoryBot.define do
  factory :usuario do
    nombre { "Pedro" }
    sequence(:username) { |n| "pedrito#{n}" }
    activo { true }
    password { "1qaz2wsx" }
    rol { 0 }
  end

  trait :admin do
    after(:build) do |usuario|
      usuario.username = "admin"
      usuario.rol = 3
    end
  end
end
