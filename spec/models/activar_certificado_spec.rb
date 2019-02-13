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

  describe "#subir!" do
    let(:emisor) do
      create :emisor, :con_direccion, con_certificado: false, rfc: "TCM970625MB1"
    end
    let(:activar_certificado) do
      build :activar_certificado, rfc: emisor.rfc
    end
    let(:valid_response) { response.new(true) }
    let(:invalid_response) { response.new(false) }
    let(:response) do
      Struct.new(:result) do
        def valid?
          result
        end
        def error
          result ? nil : "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP-ENV:Body><SOAP-ENV:Fault><faultcode>C-602</faultcode><faultstring>Contrase\xC3\xB1a de la clave privada invalida.</faultstring></SOAP-ENV:Fault></SOAP-ENV:Body></SOAP-ENV:Envelope>\n"
        end
      end
    end

    describe "certificate uploaded correctly" do
      context "when emisor doesn't have a certificate" do
        it "updates con_certificado attribute to true" do
          allow(activar_certificado).to receive(:subir_certificado).and_return(valid_response)
          activar_certificado.save
          expect(emisor.reload).to be_con_certificado
        end
      end
    end

    describe "certificate isn't uploaded correctly" do
      before :each do
        allow(activar_certificado).to receive(:subir_certificado).and_return(invalid_response)
      end

      it "con_certificado attribute not change to true" do
        activar_certificado.save
        expect(emisor).not_to be_con_certificado
      end

      context "when password is incorrect" do
        it "adds a base error" do
          activar_certificado.password = "invalid password"
          activar_certificado.save
          expect(activar_certificado.errors.keys).to include :base
        end

        context "#errors_fm_timbrado_cfdi" do
          it "displays errors from FmTimbradoCfdi" do
            activar_certificado.password = "invalid password"
            activar_certificado.save
            expect(activar_certificado.errors_fm_timbrado_cfdi).to eq "Contraseña de la clave privada invalida."
          end
        end
      end
    end
  end
end
