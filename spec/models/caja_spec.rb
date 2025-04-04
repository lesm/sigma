require 'rails_helper'

RSpec.describe Caja, type: :model do
  it { should belong_to(:cajero) }
  it { should have_many(:comprobantes) }
  it { should have_many(:historial_cajas) }

  it { should validate_presence_of(:numero) }
  it { should validate_uniqueness_of :numero }
  it { should_not allow_value(0).for(:numero) }
  it { should validate_presence_of :nombre }
  it { should validate_uniqueness_of :nombre }

  describe "#to_s" do
    let(:caja) { create :caja, nombre: "Principal", numero: "5" }

    it "returns the following format 'nombre - número'" do
      expect(caja.to_s).to eq "Principal - 5"
    end
  end

  describe "#update_historial_caja!" do
    let(:caja) { create :caja }
    let(:cajero) { create :cajero, :con_contribuyente, caja: caja }

    let(:historial_caja) do
      create :historial_caja, cajero: cajero,
        caja: caja, fecha_cierre: nil
    end

    it "historial_caja.fecha_cierre not be nil" do
      historial_caja
      caja.update_historial_caja!
      expect(historial_caja.reload.fecha_cierre).to_not be_nil
    end
  end

  describe ".no_disponibles" do
    let(:cajas_disponibles) { create_list :caja, 2, disponible: true }
    let(:cajas_no_disponibles) { create_list :caja, 2, disponible: false }

    it "must be 2" do
      cajas_no_disponibles
      expect(Caja.no_disponibles).to eq cajas_no_disponibles
    end

    it "must be empty" do
      cajas_disponibles
      expect(Caja.no_disponibles).to be_empty
    end
  end

  describe "disponibles?" do
    let(:caja) { create :caja, disponible: true }
    it "must be true" do
      caja
      expect(Caja.disponibles?).to be_truthy
    end

    it "must be false" do
      caja.update_attribute(:disponible, false)
      expect(Caja.disponibles?).to be_falsey
    end
  end

  describe "#cerrar!" do
    let(:contribuyente) do
      create :contribuyente, :con_direccion
    end
    let(:cajero) do
      create :cajero,
        contribuyente: contribuyente,
        caja: caja
    end
    let(:caja) { create :caja, disponible: true }

    it "must be false" do
      cajero
      caja.cerrar!(cajero.id)
      expect(caja).to_not be_disponible
    end
  end # describe "#cerrar!"
end
