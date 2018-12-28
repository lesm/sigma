require 'rails_helper'

RSpec.describe Concepto, type: :model do
  it { should belong_to :cuenta }
  it { should have_one(:datos_concepto).dependent(:destroy) }

  it { should validate_presence_of :valor_unitario }
  it { should validate_presence_of :clave }
  it { should validate_presence_of :clave_unidad }
  it { should validate_presence_of :importe }
  it { should validate_presence_of :cantidad }

  it { should accept_nested_attributes_for(:datos_concepto).allow_destroy(true) }
  it { should allow_values(5, 1).for(:cantidad) }

  describe "#importe" do
    let(:concepto) { build :concepto, cantidad: 2, valor_unitario: 100, importe: 300 }
    it "must be cantidad * valor_unitario" do
      concepto.valid?
      expect(concepto.errors.to_a.to_sentence).to match /debe ser 200/
    end
  end # describe  concept
end
