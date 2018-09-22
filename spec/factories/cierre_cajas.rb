FactoryBot.define do
  factory :cierre_caja do
    monto_sistema { "9.99" }
    monto_cajero { "9.99" }
    observacion { "MyText" }
    cajero { nil }
  end

  trait :with_arqueo do
    after :build do |cierre_caja|
      create_list :arqueo, 2, cierre_caja: cierre_caja
    end
  end
end
