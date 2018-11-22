require 'rails_helper'

RSpec.describe CajeroPolicy do
  let(:caja) { create :caja }
  let(:cajero) do
    create :cajero, :con_contribuyente,
      rol: 1, caja: caja
  end
  let(:admin) { create :usuario, :admin }
  let(:cajeros) do
    create_list :cajero, 5, :con_contribuyente,
      caja: caja
  end

  subject { described_class }

  permissions ".scope" do
    before { cajeros }
    context "with admin" do
      let(:policy_scope) { CajeroPolicy::Scope.new(admin, Cajero).resolve }
      it "responds all cajeros" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with cajero" do
      let(:policy_scope) { CajeroPolicy::Scope.new(cajero, Cajero).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :create? do
    it "allow access to admin" do
      expect(subject).to permit(admin, Cajero.new)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, Cajero.new)
    end
  end

  permissions :show? do
    let(:cajero_otro) { create :cajero, :con_contribuyente }
    it "allow access to admin to cajeros" do
      expect(subject).to permit(admin, cajero)
    end

    it "allow access to cajero if is the owner" do
      expect(subject).to permit(cajero, cajero)
    end

    it "denies access to cajero if is not the owner" do
      expect(subject).to_not permit(cajero, cajero_otro)
    end

  end

  permissions :edit?, :update? do
    it "allow access to admin" do
      expect(subject).to permit(admin, cajero)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, cajero)
    end
  end
end
