require 'rails_helper'

RSpec.describe Cajero, type: :model do
  it { should belong_to(:contribuyente) }
  it { should have_one(:caja) }
  it { should have_many(:cierre_cajas).dependent :destroy }
  it { should have_many(:arqueos).dependent :destroy }
  it { should have_many(:adeudos).dependent :destroy }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }
  it { should accept_nested_attributes_for(:contribuyente) }

  describe "#rol" do
    let(:contribuyente) do
      FactoryBot.create :contribuyente, :con_direccion
    end
    let(:cajero) do
      FactoryBot.create :cajero,
        contribuyente: contribuyente,
        rol: nil
    end
    it "after create must be cajero rol" do
      expect(cajero).to be_cajero
    end
  end

  context "methods to close session" do
    let(:emisor) { create :emisor, :con_direccion }
    let(:comprobante) do
      create :comprobante, :con_datos, cajero: cajero, caja: cajero.caja, emisor: emisor
    end
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:cierre_caja) do
      create :cierre_caja, cajero: cajero, abierta: true
    end

    before :each do
      cajero
    end

    describe "#arqueo_pendiente?" do
      context "when #monto_sistema is greater than 0" do
        it "is true" do
          comprobante
          expect(cajero.arqueo_pendiente?).to be_truthy
        end
      end

      context "when #monto_sistema is 0" do
        it "is false" do
          expect(cajero.arqueo_pendiente?).to be_falsey
        end
      end
    end

    describe "#cierre_caja_abierta?" do
      context "when caja has a cierre_de_caja" do
        it "is returns cierre_caja state" do
          cierre_caja
          expect(cajero.cierre_caja_abierta?).to be_truthy
        end
      end

      context "when caje has not a cierre_caja" do
        it "is returns false" do
          expect(cajero.cierre_caja_abierta?).to be_falsey
        end
      end
    end

    describe "#cierre_caja_id" do
      context "when #cierre_caja_abierta? is true" do
        it "is returns cierre_caja id" do
          cierre_caja
          expect(cajero.cierre_caja_id).to eq cierre_caja.id
        end
      end
      context "when #cierre_caja_abierta? is false" do
        it "is returns nil" do
          cierre_caja.update_column(:abierta, false)
          expect(cajero.cierre_caja_id).to be_nil
        end
      end
    end
  end

  describe "#monto_sistema" do
    context "must be the sum of comprobantes' total" do
      let(:caja) { create :caja }
      let(:cajero) { create :cajero, :con_contribuyente, nombre: "Pedro", caja: caja  }
      let(:comprobante) do
        create :comprobante, :con_datos, caja: caja, cajero: cajero
      end
      let(:comprobante_dos) do
        create :comprobante, :con_datos, caja: caja, cajero: cajero
      end
      let(:comprobante_tres) do
        create :comprobante, :con_datos, caja: caja, cajero: cajero
      end

      context "when arqueo_id is nil and there is a caja" do
        context "when exist a comprobante" do
          it "is 400" do
            comprobante
            expect(cajero.monto_sistema).to eq 400
          end
        end
        context "when exist two comprobantes" do
          it "is 800" do
            [comprobante, comprobante_dos]
            expect(cajero.monto_sistema).to eq 800
          end
        end
        context "when exist three comprobantes" do
          it "is 1200" do
            [comprobante, comprobante_dos, comprobante_tres]
            expect(cajero.monto_sistema).to eq 1200
          end
        end

        context "monto_sistema is calculating with comprobantes that were created today" do
          it "is 0" do
            create :comprobante, :con_datos, caja: caja, cajero: cajero, created_at: 2.days.ago
            expect(Comprobante.count).to eq 1
            expect(cajero.monto_sistema).to eq 0
          end
        end
      end

      context "when arqueo_id is nil and there is a caja and cajero" do
        let(:cajero) { create :cajero, :con_contribuyente, nombre: "Pedro", caja: caja  }
        let(:cajero_dos) { create :cajero, :con_contribuyente, nombre: "José", caja: caja  }
        let(:cajero_tres) { create :cajero, :con_contribuyente, nombre: "Juan", caja: caja  }

        let(:caja) { create :caja }
        context "when a comprobante belong to cajero Pedro" do
          let(:comprobante) do
            create :comprobante, :con_datos, caja: caja, cajero: cajero
          end
          let(:comprobante_dos) do
            create :comprobante, :con_datos, caja: caja, cajero: cajero_dos
          end
          let(:comprobante_tres) do
            create :comprobante, :con_datos, caja: caja, cajero: cajero_tres
          end

          it "is 400" do
            [comprobante, comprobante_dos, comprobante_tres]
            expect(cajero.monto_sistema).to eq 400
          end
        end

        context "when two comprobantes belong to cajero Pedro" do
          let(:comprobantes) do
            create_list :comprobante, 2, :con_datos, caja: caja, cajero: cajero
          end
          let(:comprobante_tres) do
            create :comprobante, :con_datos, caja: caja, cajero: cajero_tres
          end
          it "is 800" do
            [comprobantes, comprobante_tres]
            expect(cajero.monto_sistema).to eq 800
          end
        end

        context "when three comprobantes belong to cajero Pedro" do
          let(:comprobantes) do
            create_list :comprobante, 3, :con_datos, caja: caja, cajero: cajero
          end

          it "is 1200" do
            comprobantes
            expect(cajero.monto_sistema).to eq 1200
          end
        end
      end
    end
  end
end
