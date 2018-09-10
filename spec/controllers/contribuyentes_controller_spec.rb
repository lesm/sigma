require 'rails_helper'

RSpec.describe ContribuyentesController, type: :controller do

  let(:valid_attributes) do
    {
      nombre_o_razon_social: "Pedro",
      primer_apellido: "Pérez",
      segundo_apellido: "Pérez",
      persona_fisica: true,
      email: "pedro@gmail.com",
      rfc: "AAAA111111AAA"
    }
  end

  let(:invalid_attributes) do
    {
      nombre_o_razon_social: nil,
      primer_apellido: "Pérez",
      segundo_apellido: "Pérez",
      persona_fisica: true,
      email: "pedro@gmail.com",
      rfc: "AA11"
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      Contribuyente.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      contribuyente = Contribuyente.create! valid_attributes
      get :show, params: {id: contribuyente.to_param}
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
      contribuyente = Contribuyente.create! valid_attributes
      get :edit, params: {id: contribuyente.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Contribuyente" do
        expect {
          post :create, params: {contribuyente: valid_attributes}
        }.to change(Contribuyente, :count).by(1)
      end

      it "redirects to the created contribuyente" do
        post :create, params: {contribuyente: valid_attributes}
        expect(response).to redirect_to(Contribuyente.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {contribuyente: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          nombre_o_razon_social: "José",
          primer_apellido: "Pérez",
          segundo_apellido: "Pérez",
          persona_fisica: true,
          email: "pedro@gmail.com",
          rfc: "AAAA111111AAA"
        }
      end

      it "updates the requested contribuyente" do
        contribuyente = Contribuyente.create! valid_attributes
        put :update, params: {id: contribuyente.to_param, contribuyente: new_attributes}
        contribuyente.reload
        expect(contribuyente.nombre_o_razon_social).to eq "José"
      end

      it "redirects to the contribuyente" do
        contribuyente = Contribuyente.create! valid_attributes
        put :update, params: {id: contribuyente.to_param, contribuyente: valid_attributes}
        expect(response).to redirect_to(contribuyente)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        contribuyente = Contribuyente.create! valid_attributes
        put :update, params: {id: contribuyente.to_param, contribuyente: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested contribuyente" do
      contribuyente = Contribuyente.create! valid_attributes
      expect {
        delete :destroy, params: {id: contribuyente.to_param}
      }.to change(Contribuyente, :count).by(-1)
    end

    it "redirects to the contribuyentes list" do
      contribuyente = Contribuyente.create! valid_attributes
      delete :destroy, params: {id: contribuyente.to_param}
      expect(response).to redirect_to(contribuyentes_url)
    end
  end
end
