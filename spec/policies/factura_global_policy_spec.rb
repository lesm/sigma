require 'rails_helper'

RSpec.describe FacturaGlobalPolicy do

  let(:caja) { create :caja }
  let(:admin) { create :administrador }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1, caja: caja }
  let(:factura_global) { create :factura_global, :con_relaciones, caja: caja }
  let(:factura_globales) do
    create_list :factura_global, 5, :con_relaciones, caja: caja
  end

  subject { described_class }

  permissions ".scope" do
    before { factura_globales }

    context "with cajero" do
      let(:policy_scope) do
        FacturaGlobalPolicy::Scope.new(cajero, FacturaGlobal).resolve
      end

      it "responds the factura_globales" do
        expect(policy_scope.count).to eq 5
      end
    end
  end

  permissions :fechas?, :new?, :create? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, FacturaGlobal.new)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, FacturaGlobal.new)
    end
  end

  permissions :show? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, factura_global)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, factura_global)
    end
  end

end
