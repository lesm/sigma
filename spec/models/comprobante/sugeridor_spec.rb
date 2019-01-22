require "rails_helper"

RSpec.describe Comprobante::Sugeridor, type: :model do

  describe ".folio" do
    context "folios para caja 1" do
      let(:emisor) { create :emisor, numero_municipio: "482" }
      let(:caja) { build :caja, numero: 1 }

      before :each do
        allow(Date).to receive(:current).and_return(Date.new(2018))
        emisor
      end

      it "folio 482181-1 cuando es el primer comprobante" do
        expect(Comprobante::Sugeridor.folio(caja)).to eq "482181-1"
      end

      it "folio 482181-2 cuando es el segundo comprobante" do
        create :recibo, :con_datos, folio: "482181-1", caja: caja
        expect(Comprobante::Sugeridor.folio(caja)).to eq "482181-2"
      end

      it "folio 482181-3 cuando es el segundo comprobante" do
        create :recibo, :con_datos, folio: "482181-1", caja: caja
        create :recibo, :con_datos, folio: "482181-2", caja: caja
        expect(Comprobante::Sugeridor.folio(caja)).to eq "482181-3"
      end
    end

    context "folios para caja 1 y caja 2" do
      let(:caja_uno) { create :caja, numero: 1 }
      let(:caja_dos) { create :caja, numero: 2 }

      context "para 2017" do
        context "numero_municipio es 482" do
          let(:emisor) { create :emisor, numero_municipio: "482" }

          before :each do
            allow(Date).to receive(:current).and_return(Date.new(2017))
            allow(Emisor).to receive(:first).and_return(emisor)
          end

          context "folio para primer comprobante" do
            it "folio para primer comprobante de caja_uno y caja_dos" do
              expect(Comprobante::Sugeridor.folio(caja_uno)).to eq "482171-1"
              expect(Comprobante::Sugeridor.folio(caja_dos)).to eq "482172-1"
            end
          end

          context "folio para segundo comprobante" do
            it "folio para segundo comprobante de caja_uno y caja_dos" do
              create :recibo, :con_datos, folio: "482171-1", caja: caja_uno
              create :recibo, :con_datos, folio: "482172-1", caja: caja_dos
              expect(Comprobante::Sugeridor.folio(caja_uno)).to eq "482171-2"
              expect(Comprobante::Sugeridor.folio(caja_dos)).to eq "482172-2"
            end
          end

        end
      end

      context "para 2018" do
        context "numero_municipio es 500" do
          let(:emisor) { create :emisor, numero_municipio: "500" }

          it "folio para caja_uno y folio para caja_dos" do
            allow(Date).to receive(:current).and_return(Date.new(2018))
            allow(Emisor).to receive(:first).and_return(emisor)
            expect(Comprobante::Sugeridor.folio(caja_uno)).to eq "500181-1"
            expect(Comprobante::Sugeridor.folio(caja_dos)).to eq "500182-1"
          end
        end
      end
    end
  end
end
