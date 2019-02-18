require 'rails_helper'

RSpec.describe FacturaPolicy do
  let(:caja) { create :caja }
  let(:admin) { create :administrador }
  let(:cajero) do
    create :cajero, :con_contribuyente, rol: 1, caja: caja
  end
  let(:recibo) do
    create :recibo, :para_nuevo_arqueo, caja: caja, cajero: cajero
  end
  let(:facturas) do
    create_list :recibo, 5, :para_timbrar, caja: caja, type: "Factura",
      cajero: cajero
  end

  subject { described_class }

  permissions ".scope" do
    before { [facturas, recibo] }
    context "with cajero" do
      let(:policy_scope) { FacturaPolicy::Scope.new(cajero, Factura).resolve }
      it "responds all facturas" do
        expect(policy_scope.count).to eq 5
      end
    end
    context "when isn't a cajero" do
      let(:policy_scope) { FacturaPolicy::Scope.new(admin, Factura).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :show? do
    let(:factura) do
      create :recibo, :para_timbrar, caja: caja, type: "Factura",
        cajero: cajero
    end
    before { factura }
    it "allows access to cajero" do
      expect(subject).to permit(cajero, factura)
    end

    it "denies acces to admin" do
      expect(subject).to_not permit(admin, factura)
    end
  end
end
