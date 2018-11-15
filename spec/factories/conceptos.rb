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

    trait :con_datos do
      after(:build) do |concepto|
        concepto.cantidad = 2
        concepto.valor_unitario = 200
        concepto.importe = 400
      end
    end
  end
end
