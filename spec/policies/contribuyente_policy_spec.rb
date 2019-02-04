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
    create_list :contribuyente, 4, :persona_moral, :con_direccion
  end

  subject { described_class }

  permissions ".scope" do
    before { contribuyentes }
    context "with cajero" do
      let(:policy_scope) { ContribuyentePolicy::Scope.new(cajero, Contribuyente).resolve }
      it "responds all contribuyentes" do
        expect(policy_scope.count).to eq 9
      end
    end

    context "with admin" do
      let(:policy_scope) { ContribuyentePolicy::Scope.new(admin, Contribuyente).resolve }
      it "responds all 'contribuyentes morales'" do
        expect(policy_scope.count).to eq 4
      end
    end
  end

  permissions :new? do
    it "allows access to cajero" do
      expect(subject).to permit(cajero, Contribuyente.new)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, Contribuyente.new)
    end
  end

  permissions :create? do
    it "allows access to cajero" do
      expect(subject).to permit(cajero, Contribuyente.new)
    end

    it "allows access to admin" do
      expect(subject).to permit(admin, Contribuyente.new)
    end
  end

  permissions :show?, :edit?, :update? do
    it "allows access to cajero" do
      expect(subject).to permit(cajero, contribuyente)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, contribuyente)
    end
  end
end
