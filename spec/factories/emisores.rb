FactoryBot.define do
  factory :emisor do
    nombre { "HUAJUAPAN DE LEÓN" }
    numero_municipio { "482" }
    rfc { "AAA111111AAA" }
    logotipo { "MyString" }
    regimen_fiscal { "MyString" }
    registro_patronal { "MyString" }
    eslogan { "MyString" }

    trait :con_direccion do
      before(:create) do |emisor|
        emisor.direccion = build :direccion
      end
    end
  end
end
