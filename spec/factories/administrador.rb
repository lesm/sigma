FactoryBot.define do
  factory :administrador do
    nombre { "admin" }
    username { "admin" }
    activo { true }
    password { "1qaz2wsx" }
    rol { 3 }
  end
end
