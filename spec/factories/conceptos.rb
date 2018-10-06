FactoryBot.define do
  factory :concepto do
    clave { "MyString" }
    clave_unidad { "MyString" }
    unidad { "Metros" }
    cantidad { "1.0" }
    descripcion { "Pago puntual" }
    valor_unitario { "" }
    importe { 100 }
    cuenta { nil }
  end
end
