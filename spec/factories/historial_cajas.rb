FactoryBot.define do
  factory :historial_caja do
    cajero { nil }
    caja { nil }
    fecha_cierre { nil }
  end

  trait :noviembre do
    after :build do |historial_caja|
      historial_caja.created_at = "2018-11-#{rand(1..30)}".to_datetime
    end
  end

  trait :diciembre do
    after :build do |historial_caja|
      historial_caja.created_at = "2018-12-#{rand(1..31)}".to_datetime
    end
  end
end

