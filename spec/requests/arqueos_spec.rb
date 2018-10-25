require 'rails_helper'

RSpec.describe "Arqueos", type: :request do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  before :each do
    sign_in create :cajero, contribuyente: contribuyente
  end

  describe "GET /arqueos" do
    it "list of arqueos" do
      get arqueos_path
      expect(response).to have_http_status(200)
    end
  end
end
