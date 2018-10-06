require "rails_helper"

RSpec.describe ReciboStepsController, type: :controller do
  let(:contribuyente) { create :contribuyente }

  let(:cuenta_rifas) do
    create :cuenta, codigo: "110101", formato: "DatosComun",
      descripcion: "RIFAS"
  end

  let(:cuenta_predial) do
    create :cuenta, codigo: "120101", formato: "DatosPredial",
      descripcion: "PREDIAL URBANOS"
  end

  let(:valid_attributes) do 
    {
      contribuyente_id: contribuyente.id,
      cuenta_ids: [cuenta_rifas.id, cuenta_predial.id]
    }
  end

  describe "GET #show step :set_cuenta" do
    it "return a success response" do
      get :show, params: { id: :set_cuenta }
      expect(response).to be_successful
    end
  end

  describe "GET #show step :set_conceptos" do
    it "return a success response" do
      get :show, params: valid_attributes.merge!(id: :set_conceptos)
      expect(response).to be_successful
    end
  end
end
