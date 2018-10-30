require 'rails_helper'

RSpec.describe CajasHelper, type: :helper do
  describe "#disponible?" do
    let(:caja) { create :caja, disponible: true }
    it "returns 'Disponible' when caja.disponible is true" do
      expect(helper.disponible? caja).to match /Disponible/
    end

    it "returns 'No disponible' when caja.disponible is false" do
      caja.update(disponible: false)
      expect(helper.disponible? caja).to match /No disponible/
    end
  end
end
