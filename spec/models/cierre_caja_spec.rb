require 'rails_helper'

RSpec.describe CierreCaja, type: :model do
  it { should validate_presence_of(:monto_sistema) }
  it { should validate_presence_of(:monto_cajero) }
  it { should belong_to(:cajero) }
  it { should have_many(:arqueos).dependent :destroy }

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
  end
end
