FactoryBot.define do
  factory :cierre_caja do
    monto { "9.99" }
    observacion { "MyText" }
    usuario { nil }
  end

  trait :with_arqueo do
    after :build do |cierre_caja|
      create_list :arqueo, 2, cierre_caja: cierre_caja
    end
  end
end
