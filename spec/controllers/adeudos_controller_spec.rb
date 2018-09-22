require 'rails_helper'

RSpec.describe AdeudosController, type: :controller do

  let(:cajero) { FactoryBot.build :cajero }
  let(:arqueo) { FactoryBot.build :arqueo }
  let(:cierre_caja) { FactoryBot.create :cierre_caja, arqueos: [arqueo], cajero: cajero }

  let(:valid_attributes) do
    {
      :anticipo => "0",
      :monto => "9.99",
      :liquidado => false,
      :cajero_id => cajero.id,
      :arqueo_id => arqueo.id
    }
  end

  let(:invalid_attributes) do
    {
      :anticipo => "0",
      :monto => nil,
      :liquidado => false,
      :cajero_id => cajero.id,
      :arqueo_id => arqueo.id
    }
  end

  before :each do
    cierre_caja
    sign_in cajero
  end

  describe "GET #index" do
    it "returns a success response" do
      Adeudo.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      adeudo = Adeudo.create! valid_attributes
      get :show, params: {id: adeudo.to_param}
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
      adeudo = Adeudo.create! valid_attributes
      get :edit, params: {id: adeudo.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Adeudo" do
        expect {
          post :create, params: {adeudo: valid_attributes}
        }.to change(Adeudo, :count).by(1)
      end

      it "redirects to the created adeudo" do
        post :create, params: {adeudo: valid_attributes}
        expect(response).to redirect_to(Adeudo.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {adeudo: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          :anticipo => "9.99",
          :monto => "9.99",
          :liquidado => true,
          :cajero => cajero,
          :arqueo => arqueo
        }
      end

      it "updates the requested adeudo" do
        adeudo = Adeudo.create! valid_attributes
        put :update, params: {id: adeudo.to_param, adeudo: new_attributes}
        adeudo.reload
        expect(adeudo).to be_liquidado
      end

      it "redirects to the adeudo" do
        adeudo = Adeudo.create! valid_attributes
        put :update, params: {id: adeudo.to_param, adeudo: valid_attributes}
        expect(response).to redirect_to(adeudo)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        adeudo = Adeudo.create! valid_attributes
        put :update, params: {id: adeudo.to_param, adeudo: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested adeudo" do
      adeudo = Adeudo.create! valid_attributes
      expect {
        delete :destroy, params: {id: adeudo.to_param}
      }.to change(Adeudo, :count).by(-1)
    end

    it "redirects to the adeudos list" do
      adeudo = Adeudo.create! valid_attributes
      delete :destroy, params: {id: adeudo.to_param}
      expect(response).to redirect_to(adeudos_url)
    end
  end

end
