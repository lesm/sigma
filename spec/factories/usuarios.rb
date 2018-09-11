FactoryBot.define do
  factory :usuario do
    nombre "Pedro"
    sequence(:username) { |n| "pedrito#{n}" }
    activo true
    rol 0
  end
end
