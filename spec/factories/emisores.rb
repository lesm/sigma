FactoryBot.define do
  factory :emisor do
    nombre { "HUAJUAPAN DE LEÓN" }
    numero_municipio { "482" }
    rfc { "AAA111111AAA" }
    logotipo { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/logotipo.png'), 'image/png') }
    escudo { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/escudo.png'), 'image/png') }
    regimen_fiscal { "MyString" }
    registro_patronal { "MyString" }
    eslogan { "MyString" }
    con_certificado { true }

    trait :con_direccion do
      before(:create) do |emisor|
        emisor.direccion = build :direccion
      end
    end
  end
end
