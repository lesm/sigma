require "rails_helper"

RSpec.describe HistorialCajasController, type: :controller do
  let(:caja) { create :caja }
  let(:cajero) { create :cajero, :con_contribuyente, caja: caja }

  let(:valid_attributes) do
    {
      caja_id: caja.id,
      cajero_id: cajero.id
    }
  end

  let(:invalid_attributes) do
    {
      caja_id: nil,
      cajero_id: cajero.id
    }
  end

  before :each do
    sign_in usuario
  end

  describe "GET #index" do
    before :each do
      registra_municipio
    end
    let(:usuario) { create :usuario, :admin }
    it "returns a success response" do
      HistorialCaja.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    let(:usuario) { cajero }
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:usuario) { cajero }
    context "with valid params" do
      it "creates a new HistorialCaja" do
        expect {
          post :create, params: { historial_caja: valid_attributes }
        }.to change(HistorialCaja, :count).by(1)
      end

      it "redirects to the dashboard_path" do
        post :create, params: { historial_caja: valid_attributes }
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "with invalid params" do
      it "does not create a new HistorialCaja" do
        expect {
          post :create, params: { historial_caja: invalid_attributes }
        }.to change(HistorialCaja, :count).by(0)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { historial_caja: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
