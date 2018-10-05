FactoryBot.define do
  factory :concepto do
    clave { "MyString" }
    clave_unidad { "MyString" }
    unidad { "MyString" }
    cantidad { "9.99" }
    descripcion { "MyString" }
    valor_unitario { "" }
    importe { "" }
    cuenta { nil }
  end
end
