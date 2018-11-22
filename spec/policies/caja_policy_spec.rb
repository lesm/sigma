require 'rails_helper'

RSpec.describe CajaPolicy do
  let(:admin) { create :usuario, :admin }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1 }
  let(:cajas) { create_list :caja, 5 }

  subject { described_class }

  permissions ".scope" do
    before { cajas }
    context "with admin" do
      let(:policy_scope) { CajaPolicy::Scope.new(admin, Caja).resolve }
      it "responds all cajas" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with cajero" do
      let(:policy_scope) { CajaPolicy::Scope.new(cajero, Caja).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :create? do
    it "allow access to admin" do
      expect(subject).to permit(admin, Caja.new)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, Caja.new)
    end
  end

  permissions :show?, :edit?, :update? do
    let(:caja) { create :caja }
    it "allow access to admin" do
      expect(subject).to permit(admin, caja)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, caja)
    end
  end
end
