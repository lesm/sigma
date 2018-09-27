require 'rails_helper'

RSpec.describe CajerosHelper, type: :helper do
  describe "#estado_cajero" do
    it "returns 'Activo' when activo is true" do
      cajero = FactoryBot.build :cajero, activo: true
       expect(estado_cajero(cajero)).to match /Activo/
    end

    it "returns 'Inactivo' when activo is false" do
      cajero = FactoryBot.build :cajero, activo: false
      expect(estado_cajero(cajero)).to match /Inactivo/
    end
  end
end
