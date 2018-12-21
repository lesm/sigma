require 'rails_helper'

RSpec.describe DatosConcepto, type: :model do
  it { should belong_to :concepto }

  describe "#years" do
    let(:caja) { create :caja }
    let(:emisor) { create :emisor }
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:contribuyente) { create :contribuyente, :con_direccion }
    let(:cuenta) { create :cuenta, :de_licencias_y_refrendos }
    let(:concepto) do
      build :concepto, datos_concepto: datos_concepto,
        cuenta: cuenta,
        cantidad: 2,
        valor_unitario: 100,
        importe: 200
    end
    let(:comprobante) do
      create :comprobante, emisor: emisor,
        contribuyente: contribuyente,
        cajero: cajero,
        conceptos: [concepto], caja: caja,
        total: 200,
        subtotal: 200
    end

    context "remove empty string before save" do
      let(:datos_concepto) do
        build :datos_concepto, :licencia_comercial, years: ["","2015"]
      end

      it 'returns ["2015"] when received ["","2015"]' do
        expect(comprobante.conceptos.reload.first.years).to eq ["2015"]
      end
    end

    context "remove nil elements before save" do
      let(:datos_concepto) do
        build :datos_concepto, :licencia_comercial, years: [nil, "2015"]
      end

      it 'returns ["2015"] when received [nil,"2015"]' do
        expect(comprobante.conceptos.reload.first.years).to eq ["2015"]
      end
    end
  end
end
