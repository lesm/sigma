require 'rails_helper'

RSpec.describe CajasController, type: :controller do
  let(:contribuyente) { create :contribuyente, :con_direccion }

  let(:valid_attributes) do
    {
      nombre: "Primer caja",
      numero: "2",
      descripcion: "Caja del mercado",
    }
  end

  let(:invalid_attributes) do
    {
      nombre: nil,
      numero: "3",
      descripcion: "Caja del mercado",
    }
  end

  before :each do
    sign_in_admin_with_municipio
  end

  describe "GET #index" do
    it "returns a success response" do
      Caja.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      caja = Caja.create! valid_attributes
      get :show, params: { id: caja.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      caja = Caja.create! valid_attributes
      get :edit, params: { id: caja.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Caja" do
        expect {
          post :create, params: { caja: valid_attributes }
        }.to change(Caja, :count).by(1)
      end

      it "redirects to the created caja" do
        post :create, params: { caja: valid_attributes }
        expect(response).to redirect_to(Caja.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { caja: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          nombre: "Nuevo nombre"
        }
      end

      it "updates the requested caja" do
        caja = Caja.create! valid_attributes
        put :update, params: { id: caja.to_param, caja: new_attributes }
        caja.reload
        expect(caja.nombre).to eq "Nuevo nombre"
      end

      it "redirects to the caja" do
        caja = Caja.create! valid_attributes
        put :update, params: { id: caja.to_param, caja: valid_attributes }
        expect(response).to redirect_to(caja)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        caja = Caja.create! valid_attributes
        put :update, params: { id: caja.to_param, caja: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
