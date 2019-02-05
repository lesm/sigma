FactoryBot.define do
  factory :cierre_caja do
    monto_sistema { "9.99" }
    monto_cajero { "9.99" }
    observacion { "MyText" }
    abierta { true }
    automatico { false }
    cajero { nil }
  end

  trait :with_arqueo do
    after :build do |cierre_caja|
      create_list :arqueo, 2, cierre_caja: cierre_caja
    end
  end

  trait :en_ceros do
    after :build do |cierre_caja|
      cierre_caja.monto_sistema = 0
      cierre_caja.monto_cajero = 0
      cierre_caja.observacion = "En ceros"
      create_list :arqueo, 1, :en_ceros, cierre_caja: cierre_caja
    end
  end

  trait :en_ceros_con_arqueo do
    after :build do |cierre_caja|
      cierre_caja.monto_sistema = 0
      cierre_caja.monto_cajero = 0
      cierre_caja.observacion = "En ceros"
      create_list :arqueo, 1, :en_ceros, cierre_caja: cierre_caja
    end
  end
end
