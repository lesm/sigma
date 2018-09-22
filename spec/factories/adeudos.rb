FactoryBot.define do
  factory :adeudo do
    anticipo { "9.99" }
    monto { "9.99" }
    liquidado { false }
    cajero { nil }
    arqueo { nil }
  end
end
