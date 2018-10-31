require 'rails_helper'

RSpec.describe Caja, type: :model do
  it { should validate_presence_of :nombre }
  it { should validate_uniqueness_of :nombre }
  it { should belong_to(:cajero) }

  describe "cajas_disponibles?" do
    let(:caja) { create :caja, disponible: true }
    it "must be true" do
      caja
      expect(Caja.cajas_disponibles?).to be_truthy
    end

    it "must be false" do
      caja.update_attribute(:disponible, false)
      expect(Caja.cajas_disponibles?).to be_falsey
    end
  end

  describe "#cerrar!" do
    let(:caja) { create :caja, disponible: true }
    it "must be false" do
      caja.cerrar!
      expect(caja).to_not be_disponible
    end
  end # describe "#cerrar!"
end
