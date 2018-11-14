require 'rails_helper'

RSpec.describe ArqueosHelper, type: :helper do

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
            expect(helper.monto_sistema(cajero)).to eq 400
          end
        end
        context "when exist two comprobantes" do
          it "is 800" do
            [comprobante, comprobante_dos]
            expect(helper.monto_sistema(cajero)).to eq 800
          end
        end
        context "when exist three comprobantes" do
          it "is 1200" do
            [comprobante, comprobante_dos, comprobante_tres]
            expect(helper.monto_sistema(cajero)).to eq 1200
          end
        end

        context "monto_sistema is calculating with comprobantes that were created today" do
          it "is 0" do
            create :comprobante, :con_datos, caja: caja, cajero: cajero, created_at: 2.days.ago
            expect(Comprobante.count).to eq 1
            expect(helper.monto_sistema(cajero)).to eq 0
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
            expect(helper.monto_sistema(cajero)).to eq 400
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
            expect(helper.monto_sistema(cajero)).to eq 800
          end
        end

        context "when three comprobantes belong to cajero Pedro" do
          let(:comprobantes) do
            create_list :comprobante, 3, :con_datos, caja: caja, cajero: cajero
          end

          it "is 1200" do
            comprobantes
            expect(helper.monto_sistema(cajero)).to eq 1200
          end
        end
      end
    end
  end

  describe "#referer_url_cierre_caja" do
    context "request.referer is arqueos" do
      it "returns arqueos" do
        allow(helper.request).to receive(:referer).and_return ("http://localhost:3000/arqueos")
        expect(helper.referer_url_cierre_caja).to match /arqueos/
      end
    end

    context "request.referer is cierre_cajas" do
      it "returns cierre_cajas" do
        allow(helper.request).to receive(:referer).and_return ("http://localhost:3000/cierre_cajas/1")
        expect(helper.referer_url_cierre_caja).to match /cierre_cajas/
      end
    end
  end

  describe "#values_body" do
    context "When values are greater than 0" do
      context "diez_centavos, veinte_centavos, cincuenta_centavos" do
        let(:dinero) do
          FactoryBot.build :dinero,
            diez_centavos: 1,
            veinte_centavos: 2,
            cincuenta_centavos: 3,
            un_peso: 0,
            dos_pesos: 0,
            cinco_pesos: 0,
            diez_pesos: 0,
            veinte_pesos: 0,
            cincuenta_pesos: 0,
            cien_pesos: 0,
            doscientos_pesos: 0,
            quinientos_pesos: 0,
            mil_pesos: 0,
            dos_mil_pesos: 0
        end
        it "returns [1, 2, 3]" do
          @dinero = dinero
          expect(helper.values_body).to eq [1, 2, 3]
        end
      end

      context "diez_centavos, veinte_centavos, cincuenta_centavos" do
        let(:dinero) do
          FactoryBot.build :dinero,
            diez_centavos: 0,
            veinte_centavos: 0,
            cincuenta_centavos: 0,
            un_peso: 4,
            dos_pesos: 5,
            cinco_pesos: 6,
            diez_pesos: 0,
            veinte_pesos: 0,
            cincuenta_pesos: 0,
            cien_pesos: 0,
            doscientos_pesos: 0,
            quinientos_pesos: 0,
            mil_pesos: 0,
            dos_mil_pesos: 0
        end
        it "returns [4, 5, 6]" do
          @dinero = dinero
          expect(helper.values_body).to eq [4, 5, 6]
        end
      end
    end
  end

  describe "#labels_header" do
    context "When values are greater than 0" do
      context "diez_centavos, veinte_centavos and cincuenta_centavos" do
        let(:dinero) do
          FactoryBot.build :dinero,
            diez_centavos: 1,
            veinte_centavos: 1,
            cincuenta_centavos: 1,
            un_peso: 0,
            dos_pesos: 0,
            cinco_pesos: 0,
            diez_pesos: 0,
            veinte_pesos: 0,
            cincuenta_pesos: 0,
            cien_pesos: 0,
            doscientos_pesos: 0,
            quinientos_pesos: 0,
            mil_pesos: 0,
            dos_mil_pesos: 0
        end
        it "returns ['$0.1', '$0.2', '$0.5']" do
          @dinero = dinero
          expect(helper.labels_header).to eq ['$0.1', '$0.2', '$0.5']
        end
      end

      context "diez_centavos, veinte_centavos and cincuenta_centavos" do
        let(:dinero) do
          FactoryBot.build :dinero,
            diez_centavos: 0,
            veinte_centavos: 0,
            cincuenta_centavos: 0,
            un_peso: 1,
            dos_pesos: 1,
            cinco_pesos: 1,
            diez_pesos: 0,
            veinte_pesos: 0,
            cincuenta_pesos: 0,
            cien_pesos: 0,
            doscientos_pesos: 0,
            quinientos_pesos: 0,
            mil_pesos: 0,
            dos_mil_pesos: 0
        end
        it "returns ['$1.0', '$2.0', '$5.0']" do
          @dinero = dinero
          expect(helper.labels_header).to eq ['$1.0', '$2.0', '$5.0']
        end
      end
    end
  end
end
