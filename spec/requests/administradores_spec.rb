require "rails_helper"

RSpec.describe "Administradores", type: :request do
  let(:valid_attributes) do
    {
      nombre: "admin",
      username: "admin",
      password: "1qaz2wsx",
      activo: true
    }
  end

  let(:invalid_attributes) do
    {
      nombre: "admin",
      username: "admin",
      password: nil
    }
  end

  before :each do
    sign_in_cajero
  end

  describe "GET /administradores/new" do
    it "return a success response" do
      get new_administrador_path
      expect(response).to be_successful
    end
  end

  describe "GET /administradores/1/edit" do
    it "returns a success response" do
      admin = Administrador.create! valid_attributes
      get edit_administrador_path(admin)
      expect(response).to be_successful
    end
  end

  describe "GET /administradores/1" do
    it "returns a success response" do
      admin = Administrador.create! valid_attributes
      get administrador_path(admin)
      expect(response).to be_successful
    end
  end

  describe "POST /administradores" do
    context "with valid params" do
      it "creates a new administrador" do
        expect {
          post administradores_path, params: { administrador: valid_attributes }
        }.to change(Administrador, :count).by(1)
      end

      it "display a successfully created message" do
        post administradores_path, params: { administrador: valid_attributes }
        expect(flash.notice).to eq "Administrador fue creado correctamente."
      end

      it "redirects to the created administrador" do
        post administradores_path, params: { administrador: valid_attributes }
        expect(response).to redirect_to(Administrador.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post administradores_path, params: { administrador: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT /administradores/1" do
    context "with valid params" do
      let(:new_attributes) do
        {
          nombre: "Administrador",
          username: "admiadmin",
          password: "1qaz2wsx",
        }
      end

      before :each do
        @admin = Administrador.create! valid_attributes
        put administrador_path(@admin), params: { administrador: new_attributes }
      end

      it "updates the requested administrador" do
        expect(@admin.reload.nombre).to eq "Administrador"
      end

      it "redirects to the updated administrador" do
        expect(response).to redirect_to(@admin)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        admin = Administrador.create! valid_attributes
        put administrador_path(admin), params: { administrador: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
