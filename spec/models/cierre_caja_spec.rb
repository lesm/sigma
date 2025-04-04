require 'rails_helper'

RSpec.describe CierreCaja, type: :model do
  it { should belong_to(:cajero) }
  it { should have_many(:arqueos).dependent :destroy }
  it { should validate_presence_of(:monto_sistema) }
  it { should validate_presence_of(:monto_cajero) }
  it { should validate_presence_of(:cajero) }

  describe ".abiertas" do
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:cierre_cajas_abiertas) do
      create_list :cierre_caja, 5, :with_arqueo,
        cajero: cajero, abierta: true
    end
    let!(:cierre_cajas_cerradas) do
      create_list :cierre_caja, 5, :with_arqueo,
        cajero: cajero, abierta: false
    end

    it "most be 5" do
      expect(CierreCaja.abiertas).to eq cierre_cajas_abiertas
    end

    it "most be 0" do
      expect(CierreCaja.abiertas).to be_empty
    end
  end

  describe "#monto_adeudo" do
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:arqueo) do
      build :arqueo, monto_sistema: 1000,
        monto_cajero: 500
    end
    let(:arqueo_dos) do
      build :arqueo, monto_sistema: 1000,
        monto_cajero: 700
    end
    let(:cierre_caja) do
      create :cierre_caja, :en_ceros, cajero: cajero
    end

    it "returns 0" do
      expect(cierre_caja.monto_adeudo).to eq 0
    end

    it "returns 500" do
      cierre_caja.arqueos << arqueo
      expect(cierre_caja.reload.monto_adeudo).to eq 500
    end

    it "returns 800" do
      cierre_caja.arqueos << [arqueo, arqueo_dos]
      expect(cierre_caja.reload.monto_adeudo).to eq 800
    end
  end

  describe "#monto_ingreso_por_clasificar" do
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:arqueo) do
      build :arqueo, monto_sistema: 1000,
        monto_cajero: 1500
    end
    let(:arqueo_dos) do
      build :arqueo, monto_sistema: 1000,
        monto_cajero: 1300
    end
    let(:cierre_caja) do
      create :cierre_caja, :en_ceros, cajero: cajero
    end

    it "returns 0" do
      expect(cierre_caja.monto_ingreso_por_clasificar).to eq 0
    end

    it "returns 500" do
      cierre_caja.arqueos << arqueo
      cierre_caja.reload
      expect(cierre_caja.monto_ingreso_por_clasificar).to eq 500
    end

    it "returns 800" do
      cierre_caja.arqueos << [arqueo, arqueo_dos]
      cierre_caja.reload
      expect(cierre_caja.monto_ingreso_por_clasificar).to eq 800
    end
  end

  describe "Actualiza montos" do
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:arqueo) { build :arqueo, monto_sistema: 100, monto_cajero: 10 }
    let(:arqueo_2) { build :arqueo, monto_sistema: 40, monto_cajero: 40 }
    let(:cierre_caja) do
      create :cierre_caja, cajero: cajero, arqueos: [arqueo]
    end

    describe "#monto_sistema" do
      context "actualiza monto_sistema después de agregar un arqueo" do
        it 'debe ser 10' do
          expect(cierre_caja.monto_sistema).to eq 100
        end

        it 'debe ser 50' do
          cierre_caja.arqueos << arqueo_2
          expect(cierre_caja.monto_sistema).to eq 140
        end
      end
    end

    describe "#monto_cajero" do
      context "actualiza monto_cajero después de agregar un arqueo" do
        it 'debe ser 10' do
          expect(cierre_caja.monto_cajero).to eq 10
        end

        it 'debe ser 50' do
          cierre_caja.arqueos << arqueo_2
          expect(cierre_caja.monto_cajero).to eq 50
        end
      end
    end

    describe "#fecha_cierre" do
      context "when cierre_caja abierta is true" do
        let(:cajero) { create :cajero, :con_contribuyente }
        let(:cierre_caja) do
          create :cierre_caja, :with_arqueo,
            cajero: cajero, abierta: true
        end

        it "returns nil" do
          expect(cierre_caja.fecha_cierre).to be_nil
        end
      end

      context "when cierre_caja abierta is false" do
        let(:cajero) { create :cajero, :con_contribuyente }
        let(:cierre_caja) do
          create :cierre_caja, :with_arqueo,
            cajero: cajero, abierta: false
        end

        it "returns updated_at" do
          expect(cierre_caja.fecha_cierre).to eq cierre_caja.updated_at
        end
      end
    end
  end
end
