require 'rails_helper'

RSpec.describe CuentasController, type: :controller do
  let(:contribuyente) { create :contribuyente, :con_direccion }

  let(:valid_attributes) do
    {
      codigo: "123456",
      formato: "DatosComun",
      descripcion: "12345 - Algúna descripción",
      importe: 10.00,
      clave_producto: "12221212",
      clave_unidad: "E48"
    }
  end

  let(:invalid_attributes) do
    {
      codigo: nil,
      formato: "DatosComun",
      descripcion: "Algúna descripción",
      importe: 10.00,
      clave_producto: "12221212",
      clave_unidad: "E48"
    }
  end

  before :each do
    sign_in_admin_with_municipio
  end

  describe "GET #index" do
    it "returns a success response" do
      Cuenta.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      cuenta = Cuenta.create! valid_attributes
      get :show, params: { id: cuenta.to_param }
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
      cuenta = Cuenta.create! valid_attributes
      get :edit, params: { id: cuenta.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Cuenta" do
        expect {
          post :create, params: { cuenta: valid_attributes }
        }.to change(Cuenta, :count).by(1)
      end

      it "redirects to the created cuenta" do
        post :create, params: { cuenta: valid_attributes }
        expect(response).to redirect_to(Cuenta.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { cuenta: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          codigo: "123456",
          descripcion: "Algúna descripción",
          importe: 20.00,
        }
      end

      it "updates the requested cuenta" do
        cuenta = Cuenta.create! valid_attributes
        put :update, params: { id: cuenta.to_param, cuenta: new_attributes }
        cuenta.reload
        expect(cuenta.importe).to eq 20.00
      end

      it "redirects to the cuenta" do
        cuenta = Cuenta.create! valid_attributes
        put :update, params: { id: cuenta.to_param, cuenta: valid_attributes }
        expect(response).to redirect_to(cuenta)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        cuenta = Cuenta.create! valid_attributes
        put :update, params: { id: cuenta.to_param, cuenta: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested cuenta" do
      cuenta = Cuenta.create! valid_attributes
      expect {
        delete :destroy, params: { id: cuenta.to_param }
      }.to change(Cuenta, :count).by(-1)
    end

    it "redirects to the cuentas list" do
      cuenta = Cuenta.create! valid_attributes
      delete :destroy, params: { id: cuenta.to_param }
      expect(response).to redirect_to(cuentas_url)
    end
  end

end
