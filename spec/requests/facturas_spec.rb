require 'rails_helper'

RSpec.describe "Facturas", type: :request do
  before :each do
    sign_in_cajero
  end

  describe "GET /facturas" do
    it "has http status code 200" do
      get facturas_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /facturas/1" do
    it "has http status code 200" do
      factura = create :recibo, :para_timbrar, type: "Factura"
      get factura_path(factura)
      expect(response).to have_http_status(200)
    end
  end
end

