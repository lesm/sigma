require 'rails_helper'

RSpec.describe CierreCajasHelper, type: :helper do
  describe "#estado" do
    it "returns Abierta when abierta is true" do
      @cierre_caja = FactoryBot.build :cierre_caja, abierta: true
      expect(helper.estado(@cierre_caja)).to eq "Abierta"
    end

    it "returns Cerrada when abierta is false" do
      @cierre_caja = FactoryBot.build :cierre_caja, abierta: false
      expect(helper.estado(@cierre_caja)).to eq "Cerrada"
    end
  end # describe "#estado"
end
