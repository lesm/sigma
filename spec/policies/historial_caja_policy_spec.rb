require 'rails_helper'

RSpec.describe HistorialCajaPolicy do
  let(:admin) { create :administrador }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1 }
  let(:historial_cajas) do
    create_list :historial_caja, 5, cajero: cajero, caja: cajero.caja
  end

  subject { described_class }

  permissions ".scope" do
    context "with cajero" do
      let(:policy_scope) { HistorialCajaPolicy::Scope.new(admin, HistorialCaja).resolve }
      it "raise_error" do
        historial_cajas
        expect(policy_scope.count).to eq 5
      end
    end

    context "with cajero" do
      let(:policy_scope) { HistorialCajaPolicy::Scope.new(cajero, HistorialCaja).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  permissions :new?, :create? do
    it "does not allow admin to visit new" do
      expect(subject).to_not permit(admin, HistorialCaja.new)
    end

    it "allow cajero to visit new" do
      expect(subject).to permit(cajero, HistorialCaja.new)
    end
  end

end
