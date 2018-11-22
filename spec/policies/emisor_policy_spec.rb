require 'rails_helper'

RSpec.describe EmisorPolicy do
  let(:admin) { create :usuario, :admin }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1 }
  let(:emisor) { create :emisor, :con_direccion }

  subject { described_class }

  permissions ".scope" do
    before { emisor }
    context "with admin" do
      let(:policy_scope) { EmisorPolicy::Scope.new(admin, Emisor).resolve }
      it "responds the emisor" do
        expect(policy_scope.count).to eq 1
      end
    end

    context "with cajero" do
      let(:policy_scope) { EmisorPolicy::Scope.new(cajero, Emisor).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :create? do
    it "allow access to admin" do
      expect(subject).to permit(admin, Emisor.new)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, Emisor.new)
    end
  end

  permissions :show?, :edit?, :update? do
    it "allow access to admin" do
      expect(subject).to permit(admin, emisor)
    end

    it "denies access to cajero" do
      expect(subject).to_not permit(cajero, emisor)
    end
  end
end
