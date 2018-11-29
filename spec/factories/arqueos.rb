FactoryBot.define do
  factory :arqueo do
    monto_sistema { "9.99" }
    monto_cajero { "9.99" }
    observacion { "MyText" }
    cierre_caja { nil }

    trait :en_ceros do
      after :build do |arqueo|
        arqueo.monto_sistema = 0
        arqueo.monto_cajero  = 0
        arqueo.observacion = "En ceros"
      end
    end
  end
end
