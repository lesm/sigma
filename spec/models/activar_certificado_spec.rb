require 'rails_helper'

RSpec.describe ActivarCertificado, type: :model do
  it { should validate_presence_of :certificado }
  it { should validate_presence_of :llave }
  it { should validate_presence_of :rfc }
  it { should validate_presence_of :password }

  describe "#validar_extension" do
    let(:emisor) { create :emisor, :con_direccion }
    let(:activar_certificado_invalid) do
      build :activar_certificado, rfc: emisor.rfc,
        certificado: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/certificado.txt'))
    end
    let(:activar_llave_invalid) do
      build :activar_certificado, rfc: emisor.rfc,
        llave: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/llave.txt'))
    end

    it "add a key for invalid attribute" do
      activar_certificado_invalid.save
      expect(activar_certificado_invalid.errors.keys).to include :certificado
    end

    it "add a key for invalid attribute" do
      activar_llave_invalid.save
      expect(activar_llave_invalid.errors.keys).to include :llave
    end
  end
end
