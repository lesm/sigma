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

  describe "GET /factura_globales/:id" do
    let(:factura_global) { create :factura_global, :con_relaciones }

    it "returns a success response" do
      get factura_global_path factura_global
      expect(response).to have_http_status 200
    end
  end

  describe "GET /factura_globales/fechas" do
    it "returns a success response" do
      get fechas_factura_globales_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /factura_globales/new" do
    let(:emisor) { create :emisor, :con_direccion }
    let(:factura_global) do
      attributes_for(:factura_global, :con_relaciones, emisor_id: emisor.id)
        .merge!(fecha_inicio: Time.current, fecha_fin: Time.current)
    end

    it "returns a success response" do
      get new_factura_global_path, params: { factura_global: factura_global }
      expect(response).to have_http_status 200
    end
  end

end
