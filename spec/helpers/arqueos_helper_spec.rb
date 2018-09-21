require 'rails_helper'

RSpec.describe ArqueosHelper, type: :helper do

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
