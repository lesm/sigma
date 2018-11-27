require 'rails_helper'

RSpec.describe "IngresoPorClasificar", type: :request do
  before :each do
    sign_in_cajero
  end

  describe "GET /ingreso_por_clasificares" do
    it "list of ingresos por clasificar" do
      get ingreso_por_clasificares_path
      expect(response).to have_http_status(200)
    end
  end
end
