require 'rails_helper'

RSpec.describe ReciboPolicy do
  let(:caja) { create :caja }
  let(:admin) { create :usuario, :admin }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1, caja: caja }
  let(:recibo) { create :recibo, :para_nuevo_arqueo, caja: caja }
  let(:recibos) { create_list :recibo, 5, :para_nuevo_arqueo, caja: caja }

  subject { described_class }

  permissions ".scope" do
    before { recibos }
    context "with cajero" do
      let(:policy_scope) { ReciboPolicy::Scope.new(cajero, Recibo).resolve }
      it "responds the recibos" do
        expect(policy_scope.count).to eq 5
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
    it "allow access to cajero" do
      expect(subject).to permit(cajero, admin)
    end

    it "denies acces to admin" do
      expect(subject).to_not permit(admin, cajero)
    end
  end

end
