require 'rails_helper'

RSpec.describe AdministradorPolicy do
  let(:admin) { create :administrador }
  let(:super_user) { create :usuario, :super_user }

  subject { described_class }

  permissions :show? do
    it "allows access to super_user" do
      expect(subject).to permit(super_user, admin)
    end

    it "denies access if it is not a super_user" do
      expect(subject).to_not permit(admin, admin)
    end
  end

  permissions :new?, :create? do
    it "allows access to super_user" do
      expect(subject).to permit(super_user, Administrador.new)
    end

    it "denies access if it is not a super_user" do
      expect(subject).to_not permit(admin, Administrador.new)
    end
  end

  permissions :edit?, :update? do
    it "allow access to super_user" do
      expect(subject).to permit(super_user, admin)
    end

    it "denies access if it is not a super_user" do
      expect(subject).to_not permit(admin, Administrador.new)
    end
  end
end
