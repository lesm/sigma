require 'rails_helper'

RSpec.describe ArqueoPolicy do
  let(:cajero) { create :cajero, :con_contribuyente }
  let(:cajero_dos) { create :cajero, :con_contribuyente }
  let(:admin) { create :usuario, :admin }
  let(:cierre_caja) { create :cierre_caja, cajero: cajero }
  let(:cierre_caja_dos) { create :cierre_caja, cajero: cajero_dos }
  let(:arqueos_cajero_uno) { create_list :arqueo, 5, cierre_caja: cierre_caja }
  let(:arqueos_cajero_dos) { create_list :arqueo, 3, cierre_caja: cierre_caja_dos }

  subject { described_class }

  permissions ".scope" do
    before :each do
      [arqueos_cajero_uno, arqueos_cajero_dos]
    end

    context "with cajero" do
      let(:policy_scope) { ArqueoPolicy::Scope.new(cajero, Arqueo).resolve }
      it "responds all arqueos of cajero" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with cajero_dos" do
      let(:policy_scope) { ArqueoPolicy::Scope.new(cajero_dos, Arqueo).resolve }
      it "responds all arqueos of cajero_dos" do
        expect(policy_scope.count).to eq 3
      end
    end

    context "when is not a cajero" do
      let(:policy_scope) { ArqueoPolicy::Scope.new(admin, Arqueo).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :show? do
    it "allow access to cajero if cajero is owner of arqueo" do
      expect(subject).to permit(cajero, arqueos_cajero_uno.first)
    end

    it "denies access to cajero if cajero is not owner of arqueo" do
      expect(subject).to_not permit(cajero, arqueos_cajero_dos.first)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, arqueos_cajero_uno.first)
    end
  end

  permissions :new?, :create? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, Arqueo.new)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, Arqueo.new)
    end
  end
end
