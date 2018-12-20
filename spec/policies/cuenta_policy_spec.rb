require 'rails_helper'

RSpec.describe CuentaPolicy do
  let(:cajero) { create :cajero, :con_contribuyente }
  let(:admin) { create :administrador }
  let(:usuario) { create :usuario, rol: 0 }
  let(:cuentas) { create_list :cuenta, 5 }

  subject { described_class }

  permissions ".scope" do
    before :each do
      cuentas 
    end

    context "with admin" do
      let(:policy_scope) { CuentaPolicy::Scope.new(admin, Cuenta).resolve }
      it "responds all cuentas" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with cajero" do
      let(:policy_scope) { CuentaPolicy::Scope.new(cajero, Cuenta).resolve }
      it "responds all cuentas" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with usuario without rol" do
      let(:policy_scope) { CuentaPolicy::Scope.new(usuario, Cuenta).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :show?, :create? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, cuentas.first)
    end

    it "allow access to admin" do
      expect(subject).to permit(admin, cuentas.first)
    end

    it "denies access to usuario without rol" do
      expect(subject).to_not permit(usuario, cuentas.first)
    end
  end

  permissions :edit?, :update? do
    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, cuentas.first)
    end

    it "allow access to admin" do
      expect(subject).to permit(admin, cuentas.first)
    end

    it "denies access to usuario without rol" do
      expect(subject).to_not permit(usuario, cuentas.first)
    end
  end
end
