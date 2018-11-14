FactoryBot.define do
  factory :concepto do
    clave { "MyString" }
    clave_unidad { "MyString" }
    unidad { "Metros" }
    cantidad { 2 }
    descripcion { "Pago puntual" }
    valor_unitario { 100 }
    importe { 200 }
    cuenta { nil }

    trait :con_cuenta do
      after(:build) do |concepto|
        concepto.cuenta = build :cuenta
      end
    end
  end
end
