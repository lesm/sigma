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
      after :build do |concepto|
        concepto.cuenta = build :cuenta
      end
    end

    trait :con_datos do
      after :build do |concepto|
        concepto.cantidad = 2
        concepto.valor_unitario = 200
        concepto.importe = 400
      end
    end

    trait :con_cuenta_rifas do
      after :build do |concepto|
        concepto.cuenta = build :cuenta, :rifas
        concepto.clave = nil
        concepto.clave_unidad = nil
        concepto.cantidad = 1
        concepto.valor_unitario = 100
        concepto.importe = 100
        concepto.descripcion = "Pago de rifas"
      end
    end

    trait :con_cuenta_sorteos do
      after :build do |concepto|
        concepto.cuenta = build :cuenta, :sorteos
        concepto.clave = nil
        concepto.clave_unidad = nil
        concepto.cantidad = 2
        concepto.valor_unitario = 150
        concepto.importe = 300
        concepto.descripcion = "Pago de sorteos"
      end
    end
  end
end
