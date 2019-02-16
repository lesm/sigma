require 'rails_helper'

RSpec.describe "FacturaGlobales", type: :request do

  before :each do
    sign_in_cajero
  end

  describe "GET /factura_globales" do
    it "returns facturas globales" do
      get factura_globales_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /factura_globales/new" do
    it "returns a success response" do
      get new_factura_global_path
      expect(response).to have_http_status 200
    end
  end
end
