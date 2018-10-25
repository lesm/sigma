require 'rails_helper'

RSpec.describe CajerosController, type: :controller do
  let(:contribuyente) do
    FactoryBot.create :contribuyente, :con_direccion
  end

  let(:valid_attributes) do
    {
      nombre: "Cajero",
      username: "cajerito",
      password: "1qaz2wsx",
      activo: true,
      rol: 1,
      contribuyente_id: contribuyente.id
    }
  end

  let(:invalid_attributes) do
    {
      nombre: "Cajero",
      username: nil,
      password: "1qaz2wsx",
      activo: true,
      rol: 1,
      contribuyente_attributes: contribuyente
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      Cajero.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      cajero = Cajero.create! valid_attributes
      get :show, params: {id: cajero.to_param}
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
      cajero = Cajero.create! valid_attributes
      get :edit, params: {id: cajero.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Cajero" do
        expect {
          post :create, params: {cajero: valid_attributes}
        }.to change(Cajero, :count).by(1)
      end

      it "creates a new Contribuyente" do
        expect {
          post :create, params: {cajero: valid_attributes}
        }.to change(Contribuyente, :count).by(1)
      end

      it "creates a new Dirección" do
        expect {
          post :create, params: {cajero: valid_attributes}
        }.to change(Direccion, :count).by(1)
      end

      it "redirects to the created cajero" do
        post :create, params: {cajero: valid_attributes}
        expect(response).to redirect_to(Cajero.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {cajero: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          nombre: "Cajero",
          username: "cajerito",
          password: "1qaz2wsx",
          activo: false,
          rol: 1,
          contribuyente_attributes: contribuyente
        }
      end

      context "password is blank" do
        context "after update password doesn't change" do
          let(:new_attributes) do
            {
              nombre: "Cajero",
              username: "cajerito",
              password: "",
              activo: false,
              rol: 1,
              contribuyente_attributes: contribuyente
            }
          end

          it "password must be '1qaz2wsx'" do
            cajero = Cajero.create! valid_attributes
            put :update, params: {id: cajero.to_param, cajero: new_attributes}
            cajero.reload
            expect(cajero.password).to eq "1qaz2wsx"
          end
        end
      end

      it "updates the requested cajero" do
        cajero = Cajero.create! valid_attributes
        put :update, params: {id: cajero.to_param, cajero: new_attributes}
        cajero.reload
        expect(cajero).to_not be_activo
      end

      it "redirects to the cajero" do
        cajero = Cajero.create! valid_attributes
        put :update, params: {id: cajero.to_param, cajero: valid_attributes}
        expect(response).to redirect_to(cajero)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        cajero = Cajero.create! valid_attributes
        put :update, params: {id: cajero.to_param, cajero: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested cajero" do
      cajero = Cajero.create! valid_attributes
      expect {
        delete :destroy, params: {id: cajero.to_param}
      }.to change(Cajero, :count).by(-1)
    end

    it "redirects to the cajeros list" do
      cajero = Cajero.create! valid_attributes
      delete :destroy, params: {id: cajero.to_param}
      expect(response).to redirect_to(cajeros_url)
    end
  end

end
