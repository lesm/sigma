require "rails_helper"

RSpec.describe DineroPresenter do
  let(:dinero_presenter) { DineroPresenter.new dinero }

  context "when quantity is 1" do
    let(:dinero) do
      FactoryBot.build :dinero,
        diez_centavos: 1,
        veinte_centavos: 1,
        cincuenta_centavos: 1,
        un_peso: 1,
        dos_pesos: 1,
        cinco_pesos: 1,
        diez_pesos: 1,
        veinte_pesos: 1,
        cincuenta_pesos: 1,
        cien_pesos: 1,
        doscientos_pesos: 1,
        quinientos_pesos: 1,
        mil_pesos: 1,
        dos_mil_pesos: 1
    end

    it { expect(dinero_presenter.diez_centavos).to eq 0.10 }
    it { expect(dinero_presenter.veinte_centavos).to eq 0.20 }
    it { expect(dinero_presenter.cincuenta_centavos).to eq 0.50 }
    it { expect(dinero_presenter.un_peso).to eq 1.0 }
    it { expect(dinero_presenter.dos_pesos).to eq 2.0 }
    it { expect(dinero_presenter.cinco_pesos).to eq 5.0 }
    it { expect(dinero_presenter.diez_pesos).to eq 10.0 }
    it { expect(dinero_presenter.veinte_pesos).to eq 20.0 }
    it { expect(dinero_presenter.cincuenta_pesos).to eq 50.0 }
    it { expect(dinero_presenter.cien_pesos).to eq 100.0 }
    it { expect(dinero_presenter.doscientos_pesos).to eq 200.0 }
    it { expect(dinero_presenter.quinientos_pesos).to eq 500.0 }
    it { expect(dinero_presenter.mil_pesos).to eq 1000.0 }
    it { expect(dinero_presenter.dos_mil_pesos).to eq 2000.0 }

    it "#total" do
      expect(dinero_presenter.total).to eq 3888.8
    end
  end

  context "when quantity is 2" do
    let(:dinero) do
      FactoryBot.build :dinero,
        diez_centavos: 2,
        veinte_centavos: 2,
        cincuenta_centavos: 2,
        un_peso: 2,
        dos_pesos: 2,
        cinco_pesos: 2,
        diez_pesos: 2,
        veinte_pesos: 2,
        cincuenta_pesos: 2,
        cien_pesos: 2,
        doscientos_pesos: 2,
        quinientos_pesos: 2,
        mil_pesos: 2,
        dos_mil_pesos: 2
    end

    it { expect(dinero_presenter.diez_centavos).to eq 0.20 }
    it { expect(dinero_presenter.veinte_centavos).to eq 0.40 }
    it { expect(dinero_presenter.cincuenta_centavos).to eq 1.0 }
    it { expect(dinero_presenter.un_peso).to eq 2.0 }
    it { expect(dinero_presenter.dos_pesos).to eq 4.0 }
    it { expect(dinero_presenter.cinco_pesos).to eq 10.0 }
    it { expect(dinero_presenter.diez_pesos).to eq 20.0 }
    it { expect(dinero_presenter.veinte_pesos).to eq 40.0 }
    it { expect(dinero_presenter.cincuenta_pesos).to eq 100.0 }
    it { expect(dinero_presenter.cien_pesos).to eq 200.0 }
    it { expect(dinero_presenter.doscientos_pesos).to eq 400.0 }
    it { expect(dinero_presenter.quinientos_pesos).to eq 1000.0 }
    it { expect(dinero_presenter.mil_pesos).to eq 2000.0 }
    it { expect(dinero_presenter.dos_mil_pesos).to eq 4000.0 }

    it "#total" do
      expect(dinero_presenter.total).to eq 7777.6 
    end
  end
end
