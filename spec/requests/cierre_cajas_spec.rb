require 'rails_helper'

RSpec.describe "CierreCajas", type: :request do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  before :each do
    sign_in create :cajero, contribuyente: contribuyente
  end

  describe "GET /cierre_cajas" do
    it "works! (now write some real specs)" do
      get cierre_cajas_path
      expect(response).to have_http_status(200)
    end
  end
end
