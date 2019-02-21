require 'rails_helper'

RSpec.describe ReciboPolicy do
  let(:caja) { create :caja }
  let(:admin) { create :administrador }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1, caja: caja }
  let(:factura) do
    create :recibo, :para_timbrar, caja: caja, cajero: cajero, type: "Factura"
  end
  let(:recibos) do
    create_list :recibo, 5, :para_nuevo_arqueo, caja: caja, cajero: cajero
  end

  subject { described_class }

  permissions ".scope" do
    before { [recibos, factura] }
    context "with cajero" do
      let(:policy_scope) { ReciboPolicy::Scope.new(cajero, Recibo).resolve }
      it "responds all recibos" do
        expect(policy_scope.count).to eq 5
      end
    end
    context "when isn't a cajero" do
      let(:policy_scope) { ReciboPolicy::Scope.new(admin, Recibo).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :create? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, Recibo.new)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, Recibo.new)
    end
  end

  permissions :show? do
    let(:recibo) do
      create :recibo, :para_nuevo_arqueo, caja: caja, cajero: cajero
    end

    it "allow access to cajero" do
      expect(subject).to permit(cajero, recibo)
    end

    it "denies acces to admin" do
      expect(subject).to_not permit(admin, recibo)
    end
  end
end
