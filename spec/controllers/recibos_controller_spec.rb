require 'rails_helper'

RSpec.describe RecibosController, type: :controller do
  let(:caja) { create :caja }
  let(:cuenta_rifas) do
    create :cuenta, codigo: "110101", formato: "DatosComun",
      descripcion: "RIFAS"
  end

  let(:cuenta_sorteos) do
    create :cuenta, codigo: "110102", formato: "DatosComun",
      descripcion: "SORTEOS"
  end

  let(:emisor) { create :emisor }
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) do
    create :cajero,
      contribuyente: contribuyente,
      caja: caja
  end
  let(:cuenta) { create :cuenta }
  let(:cuenta_ids) { [cuenta_rifas.id, cuenta_sorteos.id] }

  let(:conceptos_attributes) do
    [
      attributes_for(:concepto).merge!(
        cuenta_id: cuenta_rifas.id,
        datos_concepto_attributes: attributes_for(:datos_concepto, :datos_comun)
      ),
      attributes_for(:concepto).merge!(
        cuenta_id: cuenta_sorteos.id,
        datos_concepto_attributes: attributes_for(:datos_concepto, :datos_comun)
      )
    ]
  end

  let(:valid_attributes) do
    {
      serie: "A",
      folio: "1",
      moneda: "MXN",
      tipo_comprobante:  "Factura",
      lugar_expedicion:  "68300",
      metodo_pago: "Pago en una sola exhibición",
      forma_pago: "Efectivo",
      subtotal: 2500,
      descuento: 0,
      total: 2500,
      motivo_descuento: "por pago puntual",
      fecha_emision: Date.current,
      observaciones: "pago puntual",
      cajero_id:  cajero.id,
      contribuyente_id:  contribuyente.id,
      emisor_id:  emisor.id,
      caja_id: caja.id,
      conceptos_attributes: conceptos_attributes
    }
  end

  let(:invalid_attributes) do
    {
      serie: "A",
      folio: "1",
      moneda: "MXN",
      tipo_comprobante:  "Factura",
      lugar_expedicion:  "68300",
      metodo_pago: "Pago en una sola exhibición",
      forma_pago: "Efectivo",
      subtotal: 0,
      descuento: 0,
      total: 0,
      motivo_descuento: "por pago puntual",
      fecha_emision: Date.current,
      observaciones: "pago puntual",
      cajero_id:  cajero.id,
      contribuyente_id:  contribuyente.id,
      emisor_id:  emisor.id,
      caja_id: caja.id
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      Recibo.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      recibo = Recibo.create! valid_attributes
      get :show, params: { id: recibo.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Recibo" do
        expect {
          post :create, params: { recibo: valid_attributes, cuenta_ids: cuenta_ids, contribuyente_id: contribuyente.id }
        }.to change(Recibo, :count).by(1)
      end

      context 'Conceptos' do
        it "creates two new Conceptos" do
          expect {
            post :create, params: { recibo: valid_attributes, cuenta_ids: cuenta_ids, contribuyente_id: contribuyente.id }
          }.to change(Concepto, :count).by(2)
        end

        it "creates two new DatosConcepto" do
          expect {
            post :create, params: { recibo: valid_attributes, cuenta_ids: cuenta_ids, contribuyente_id: contribuyente.id }
          }.to change(DatosConcepto, :count).by(2)
        end
      end

      it "redirects to the created recibo" do
        post :create, params: { recibo: valid_attributes }
        expect(response).to redirect_to(Recibo.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { recibo: invalid_attributes, cuenta_ids: cuenta_ids, contribuyente_id: contribuyente.id }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recibo" do
      recibo = Recibo.create! valid_attributes
      expect {
        delete :destroy, params: { id: recibo.to_param }
      }.to change(Recibo, :count).by(-1)
    end

    it "redirects to the recibos list" do
      recibo = Recibo.create! valid_attributes
      delete :destroy, params: { id: recibo.to_param }
      expect(response).to redirect_to(recibos_url)
    end
  end
end
