require 'rails_helper'

RSpec.describe ContribuyentePolicy do
  let(:admin) { create :administrador }
  let(:cajero) do
    create :cajero, :con_contribuyente,
      rol: 1, contribuyente: contribuyente
  end
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:contribuyentes) do
    create_list :contribuyente, 4, :con_direccion
  end

  subject { described_class }

  permissions ".scope" do
    before { contribuyentes }
    context "with cajero" do
      let(:policy_scope) { ContribuyentePolicy::Scope.new(cajero, Contribuyente).resolve }
      it "responds all contribuyentes" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with admin" do
      let(:policy_scope) { ContribuyentePolicy::Scope.new(admin, Contribuyente).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :create? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, Contribuyente.new)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, Contribuyente.new)
    end
  end

  permissions :show?, :edit?, :update? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, contribuyente)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, contribuyente)
    end
  end

end
