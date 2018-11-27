require "rails_helper"

RSpec.describe IngresoPorClasificaresController, type: :controller do
  let(:cajero) { create :cajero, :con_contribuyente }
  let(:arqueo) { build :arqueo }
  let(:cierre_caja) do
    create :cierre_caja, arqueos: [arqueo],
      cajero: cajero
  end

  let(:valid_attributes) do
    {
      monto: 100,
      cajero: cajero,
      arqueo: arqueo
    }
  end

  let(:invalid_attributes) do
    {
      monto: nil,
      cajero: cajero,
      arqueo: arqueo
    }
  end

  before :each do
    sign_in cajero
  end

  describe "GET #index" do
    it "returns a success response" do
      IngresoPorClasificar.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end
end
