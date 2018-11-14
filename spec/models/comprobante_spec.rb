require 'rails_helper'

RSpec.describe Comprobante, type: :model do
  it { should belong_to :caja }
  it { should belong_to :arqueo }
  it { should belong_to :cajero }
  it { should belong_to :contribuyente }
  it { should belong_to :emisor }

  it { should have_many(:conceptos).dependent(:destroy) }
  it { should accept_nested_attributes_for :conceptos }

  it { should validate_presence_of :folio }
  it { should validate_presence_of :moneda }
  it { should validate_presence_of :tipo_comprobante }
  it { should validate_presence_of :lugar_expedicion }
  it { should validate_presence_of :metodo_pago }
  it { should validate_presence_of :forma_pago }
  it { should validate_presence_of :subtotal }
  it { should validate_presence_of :descuento }
  it { should validate_presence_of :total }
  it { should validate_numericality_of(:total).is_greater_than(0) }
  it { should validate_numericality_of(:subtotal).is_greater_than(0) }

  describe "#valida_subtotal" do
    let(:concepto) { build :concepto, cantidad: 2, valor_unitario: 200, importe: 400 }
    let(:comprobante) { build :comprobante, conceptos: [concepto], subtotal: 500, total: 400 }
    context "#subtotal" do
      it "must be equals to total" do
        expect(comprobante).to be_invalid
        expect(comprobante.errors.to_a.to_sentence).to match /debe ser igual a total/
      end
    end
  end

  describe "#valida_total" do
    let(:concepto) { build :concepto, cantidad: 2, valor_unitario: 200, importe: 400 }
    let(:comprobante) { build :comprobante, conceptos: [concepto], subtotal: 400, total: 500 }
    context "#total" do
      it "must be equals to sum of conceptos' importe" do
        expect(comprobante).to be_invalid
        expect(comprobante.errors.to_a.to_sentence).to match /debe ser igual a la suma del importe de los conceptos/
      end
    end
  end
end
