require 'rails_helper'

RSpec.describe EmisoresController, type: :controller do

  let(:direccion) do
    {
      calle: "una calee",
      numero: "s/n",
      colonia: "una colonia",
      codigo_postal: "68300",
      localidad: "una localida",
      municipio: "un municipio",
      estado: "Oaxaca",
      pais: "México"
    }
  end

  let(:valid_attributes) do
    {
      nombre: "Municipio",
      rfc: "AAA111111AAA",
      logotipo: "Logo",
      regimen_fiscal: "Regimen Fiscal",
      registro_patronal: "Registro Patronal",
      eslogan: "Lugar Expedición",
      direccion_attributes: direccion
    }
  end

  let(:invalid_attributes) do
    {
      nombre: nil,
      rfc: nil,
      logotipo: "Logo",
      regimen_fiscal: "Regimen Fiscal",
      registro_patronal: "Registro Patronal",
      eslogan: "Lugar Expedición"
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      Emisor.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      emisor = Emisor.create! valid_attributes
      get :show, params: {id: emisor.to_param}
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
      emisor = Emisor.create! valid_attributes
      get :edit, params: {id: emisor.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Emisor" do
        expect {
          post :create, params: {emisor: valid_attributes}
        }.to change(Emisor, :count).by(1)
      end

      it "creates a new Dirección" do
        expect {
          post :create, params: {emisor: valid_attributes}
        }.to change(Direccion, :count).by(1)
      end

      it "redirects to the created emisor" do
        post :create, params: {emisor: valid_attributes}
        expect(response).to redirect_to(Emisor.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {emisor: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          nombre: "Municipio 2",
          rfc: "AAA111111AAA",
          logo: "Logo",
          regimen_fiscal: "Regimen Fiscal",
          registro_patronal: "Registro Patronal",
          lugar_expedicion: "Lugar Expedición"
        }
      end

      it "updates the requested emisor" do
        emisor = Emisor.create! valid_attributes
        put :update, params: {id: emisor.to_param, emisor: new_attributes}
        emisor.reload
        expect(emisor.nombre).to eq "Municipio 2"
      end

      it "redirects to the emisor" do
        emisor = Emisor.create! valid_attributes
        put :update, params: {id: emisor.to_param, emisor: valid_attributes}
        expect(response).to redirect_to(emisor)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        emisor = Emisor.create! valid_attributes
        put :update, params: {id: emisor.to_param, emisor: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested emisor" do
      emisor = Emisor.create! valid_attributes
      expect {
        delete :destroy, params: {id: emisor.to_param}
      }.to change(Emisor, :count).by(-1)
    end

    it "redirects to the emisores list" do
      emisor = Emisor.create! valid_attributes
      delete :destroy, params: {id: emisor.to_param}
      expect(response).to redirect_to(emisores_url)
    end
  end

end
