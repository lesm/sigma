require "rails_helper"

RSpec.describe "ActivarCertificados", type: :request do
  let(:valid_attributes) do
    {
      rfc: "TCM970625MB1",
      certificado: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/certificado.cer')),
      llave: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/llave.key')),
      password: "12345678a"
    }
  end

  let(:invalid_attributes) do
    {
      rfc: "TCM970625MB1",
      certificado: nil,
      llave: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/llave.key')),
      password: "1qaz2wx"
    }
  end

  before :each do
    sign_in_admin_with_municipio
  end

  describe "GET /activar_certificados/new" do
    it "returns a success response " do
      get new_activar_certificado_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /activar_certificados" do
    context "with valid params" do
      it "display a successfully message", :vcr do
        post activar_certificados_path, params: { activar_certificado: valid_attributes }
        expect(flash.notice).to eq "Certificado activado correctamente."
        expect(flash.alert).to be_nil
      end

      it "redirects to root_path", :vcr do
        post activar_certificados_path, params: { activar_certificado: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "display a failure message" do
        post activar_certificados_path, params: { activar_certificado: invalid_attributes }
        expect(flash.alert).to eq "El certificado no válido."
        expect(flash.notice).to be_nil
      end

      it "display a 'new' template" do
        post activar_certificados_path, params: { activar_certificado: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
