require "rails_helper"

RSpec.describe ConceptoPresenter do
  let(:subject) { ConceptoPresenter.new concepto }
  let(:concepto) { build :concepto }

  describe "#descuento" do
    it "receives 0 and return nil" do
      expect(subject.descuento).to be_nil
    end
  end

  describe "#valor_unitario" do
    it "receives 100.5 and return 100.50" do
      subject.valor_unitario = 100.5
      expect(subject.valor_unitario).to eq "100.50"
    end
  end

  describe "#importe" do
    it "receives 200.5 and return 200.50" do
      subject.importe = 200.5
      expect(subject.importe).to eq "200.50"
    end
  end
end

