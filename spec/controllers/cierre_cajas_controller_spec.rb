require 'rails_helper'

RSpec.describe CierreCajasController, type: :controller do

  let(:contribuyente) do
    FactoryBot.create :contribuyente, :con_direccion
  end
  let(:cajero) do
    FactoryBot.create :cajero,
      nombre: "Pedro",
      password: "qwerty",
      contribuyente: contribuyente
  end
  let(:valid_attributes) do
    {
      monto_sistema: 100.00,
      monto_cajero: 100.00,
      observacion: "Alguna observación",
      cajero_id: cajero.id
    }
  end

  let(:invalid_attributes) do
    {
      monto_sistema: 0,
      monto_cajero: 0,
      observacion: "",
      cajero_id: nil
    }
  end

  before :each do
    sign_in cajero
  end

  describe "GET #index" do
    it "returns a success response" do
      CierreCaja.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      cierre_caja = CierreCaja.create! valid_attributes
      get :show, params: {id: cierre_caja.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new CierreCaja" do
        expect {
          post :create, params: {cierre_caja: valid_attributes}
        }.to change(CierreCaja, :count).by(1)
      end

      it "redirects to the created cierre_caja" do
        post :create, params: {cierre_caja: valid_attributes}
        expect(response).to redirect_to(CierreCaja.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {cierre_caja: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
end
