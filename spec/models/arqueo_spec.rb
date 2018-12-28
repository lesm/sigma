require 'rails_helper'

RSpec.describe Arqueo, type: :model do
  it { should belong_to :cierre_caja }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }
  it { should have_one(:dinero).dependent(:destroy) }
  it { should have_one(:adeudo).dependent(:destroy) }
  it { should have_one(:ingreso_por_clasificar).dependent(:destroy) }
  it { should accept_nested_attributes_for(:dinero).allow_destroy(true) }
  it { should validate_presence_of :monto_cajero }
  it { should_not allow_value(-1).for :monto_cajero }
  it { should allow_value(0).for :monto_cajero }
  it { should allow_value(10.5).for :monto_cajero }
  it { should_not allow_value(-1).for :monto_sistema }
  it { should allow_value(0).for :monto_sistema }
  it { should allow_value(10.5).for :monto_sistema }

  describe "montos" do
    let(:emisor) { create :emisor, :con_direccion }
    let(:cajero) { create :cajero, :con_contribuyente }
    let(:cierre_caja) { create :cierre_caja, cajero: cajero }
    let(:dinero) { build :dinero, doscientos_pesos: 2, total: 2000 }
    let(:arqueo) do
      create :arqueo, monto_sistema: 2000,
        monto_cajero: 2000,
        dinero: dinero,
        cierre_caja: cierre_caja
    end

    let(:formas_pago) do
      ["01 - Efectivo", "02 - Cheque nominativo",
       "04 - Tarjeta de crédito", "28 - Tarjeta de débito",
       "03 - Transferencia electrónica de fondos"]
    end

    before :each do
      formas_pago.each do |forma_pago|
        create :recibo, :con_datos,
          forma_pago: forma_pago,
          emisor: emisor,
          cajero: cajero,
          caja: cajero.caja,
          arqueo: arqueo
      end
    end

    describe "#monto_cheque" do
      it "is 400" do
        expect(arqueo.monto_cheque).to eq 400
      end
    end

    describe "#monto_debito" do
      it "is 400" do
        expect(arqueo.monto_debito).to eq 400
      end
    end

    describe "#monto_crédito" do
      it "is 400" do
        expect(arqueo.monto_credito).to eq 400
      end
    end

    describe "#monto_transferencia" do
      it "is 400" do
        expect(arqueo.monto_transferencia).to eq 400
      end
    end

    describe "#monto_efectivo" do
      it "is 400" do
        expect(arqueo.monto_efectivo).to eq 400
      end
    end

    describe "#monto_no_efectivo" do
      it "is 1600" do
        expect(arqueo.monto_no_efectivo).to eq 1600
      end
    end

  end

  describe "#crear_ingreso_por_clasificar" do
    context "when monto_cajero greater than monto_sistema" do
      let(:cajero) { create :cajero, :con_contribuyente }
      let(:cierre_caja) { build :cierre_caja, cajero: cajero }
      let(:dinero) do
        build :dinero, dos_mil_pesos: 1, total: 2000
      end
      let(:arqueo) do
        create :arqueo, cierre_caja: cierre_caja,
          dinero: dinero, monto_cajero: 2000, monto_sistema: 1000
      end

      it "creates a IngresoPorClasificar with monto $1,000.00" do
        arqueo
        expect(IngresoPorClasificar.first.monto).to eq 1000
      end
    end
  end
end
