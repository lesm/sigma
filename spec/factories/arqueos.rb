FactoryBot.define do
  factory :arqueo do
    monto_sistema { "9.99" }
    monto_cajero { "9.99" }
    observacion { "MyText" }
    cierre_caja { nil }
  end
end
