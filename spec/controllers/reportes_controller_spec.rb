require 'rails_helper'

RSpec.describe ReportesController, type: :controller do
  let(:contribuyente) do
    FactoryBot.create :contribuyente, :con_direccion
  end
  let(:cajero) do
    FactoryBot.create :cajero,
      nombre: "Pedro",
      password: "qwerty",
      contribuyente: contribuyente
  end

  let(:cuenta) { create :cuenta, :rifas }

  before :each do
    sign_in_admin_with_municipio
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { nombre: "cajero" }
      expect(response).to be_successful
    end
  end

  describe "POST #cajeros" do
    let(:valid_attributes) do
      {
        nombre: "cajero",
        cajero_id: cajero.id,
        fecha_inicial: 3.months.ago,
        fecha_final: Date.current
      }
    end

    let(:invalid_attributes) do
      {
        nombre: "cajero",
        cajero_id: cajero.id,
        fecha_inicial: 3.months.ago,
        fecha_final: nil
      }
    end

    context "with valid params" do
      it "download a pdf file" do
        post :cajeros, params: { reporte_form: valid_attributes }
        expect(response.content_type).to eq "application/pdf"
      end
    end

    context "with valid params" do
      it "renders to new" do
        post :cajeros, params: { reporte_form: valid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "POST #cuentas" do
    let(:valid_attributes) do
      {
        nombre: "cuenta",
        cuenta_id: cuenta.id,
        fecha_inicial: 3.months.ago,
        fecha_final: Date.current
      }
    end

    let(:invalid_attributes) do
      {
        nombre: "cajero",
        cuenta_id: cuenta.id,
        fecha_inicial: 3.months.ago,
        fecha_final: nil
      }
    end

    context "with valid params" do
      it "download a pdf file" do
        post :cuentas, params: { reporte_form: valid_attributes }
        expect(response.content_type).to eq "application/pdf"
      end
    end

    context "with valid params" do
      it "renders to new" do
        post :cuentas, params: { reporte_form: valid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
