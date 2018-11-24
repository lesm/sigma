require 'rails_helper'

RSpec.describe CierreCajaPolicy do
  let(:admin) { create :usuario, :admin }

  let(:cajero) { create :cajero, :con_contribuyente, rol: 1 }
  let(:cierre_caja) { create :cierre_caja, :with_arqueo, cajero: cajero }
  let(:cierre_cajas) do
    create_list :cierre_caja, 5, :with_arqueo, cajero: cajero
  end

  let(:cajero_uno) { create :cajero, :con_contribuyente, rol: 1 }
  let(:cierre_caja_uno) do
    create :cierre_caja, :with_arqueo, cajero: cajero_uno
  end

  subject { described_class }

  permissions ".scope" do
    before { cierre_cajas }
    context "with cajero" do
      let(:policy_scope) { CierreCajaPolicy::Scope.new(cajero, CierreCaja).resolve }
      it "responds all cierre_cajas" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with admin" do
      let(:policy_scope) { CierreCajaPolicy::Scope.new(admin, CierreCaja).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :edit?, :update? do
    it "allow access to cajero uno if cajero_uno the owner" do
      expect(subject).to permit(cajero_uno, cierre_caja_uno)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, cierre_caja_uno)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, cierre_caja_uno)
    end
  end

  permissions :show?, :cerrar? do
    it "allow cerrar if cajero is owner of cierre_caja" do
      expect(subject).to permit(cajero_uno, cierre_caja_uno)
    end

    it "denies cerrar if cajero is not owner of cierre_caja" do
      expect(subject).to_not permit(cajero, cierre_caja_uno)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, cierre_caja_uno)
    end
  end
end
