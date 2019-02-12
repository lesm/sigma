FactoryBot.define do
  factory :activar_certificado do
    rfc { "AA#{FactoryBotHelpers.random_values_rfc}" }
    password { "12345678a" }
    certificado { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/certificado.cer')) }
    llave { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/llave.key')) }
  end
end
