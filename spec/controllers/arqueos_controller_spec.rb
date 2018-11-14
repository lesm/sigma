require 'rails_helper'

RSpec.describe ArqueosController, type: :controller do

  let(:contribuyente) do
    FactoryBot.create :contribuyente, :con_direccion
  end
  let(:cajero) do
    FactoryBot.create :cajero, contribuyente: contribuyente
  end
  let(:dinero_attributes) { FactoryBot.attributes_for :dinero }

  let(:cierre_caja) do
    FactoryBot.create :cierre_caja,
      monto_sistema: 300,
      monto_cajero: 300,
      cajero: cajero
  end

  let(:valid_attributes) do
    {
      monto_sistema: 250.56,
      monto_cajero: 200.56,
      observacion: "Primer arqueo del día",
      cierre_caja_id: cierre_caja.id,
      dinero_attributes: dinero_attributes
    }
  end

  let(:invalid_attributes) do
    {
      monto_sistema: 0,
      monto_cajero: 0,
      observacion: "Primer arqueo del día",
      cierre_caja_id: cierre_caja.id
    }
  end

  before :each do
    sign_in cajero
  end

  describe "GET #index" do
    it "returns a success response" do
      Arqueo.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      arqueo = Arqueo.create! valid_attributes
      get :show, params: { id: arqueo.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Arqueo" do
        expect {
          post :create, params: { arqueo: valid_attributes }
        }.to change(Arqueo, :count).by(1)
      end

      it "creates a new Dinero" do
        expect {
          post :create, params: { arqueo: valid_attributes }
        }.to change(Dinero, :count).by(1)
      end

      it "redirects to the created arqueo" do
        post :create, params: { arqueo: valid_attributes }
        expect(response).to redirect_to(Arqueo.last)
      end

      context "when monto_sistema is different of monto_cajero" do
        it "creates a new Adeudo" do
          expect {
            post :create, params: { arqueo: valid_attributes }
          }.to change(Adeudo, :count).by(1)
        end

        it "monto Adeudo must be $50.00" do
          post :create, params: { arqueo: valid_attributes }
          expect(Adeudo.last.monto).to eq 50.00
        end
      end

      context "when cierre_caja does not exist" do
        it "creates a cierre_caja" do
          expect {
            post :create, params: { arqueo: valid_attributes }
          }.to change(CierreCaja, :count).by(1)
        end
      end

      context "when cierre_caja exists" do
        it "does not create a cierre_caja" do
          cierre_caja
          expect {
            post :create, params: { arqueo: valid_attributes }
          }.to change(CierreCaja, :count).by(0)
        end
      end

      context "when exist a comprobante" do
        context "where comprobante.arqueo_id is nil" do
          let(:conceptos) { build :concepto, :con_datos }
          let(:comprobante) { create :comprobante, :con_datos, caja: cajero.caja, arqueo_id: nil }
          it "comprobante must belong to the new arqueo" do
            comprobante
            allow_any_instance_of(ApplicationController).to receive(:current_usuario).and_return(cajero)
            post :create, params: { arqueo: valid_attributes }
            expect(comprobante.reload.arqueo).to eq Arqueo.last
          end
        end
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { arqueo: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
