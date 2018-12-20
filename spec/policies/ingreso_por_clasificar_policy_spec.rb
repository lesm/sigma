require 'rails_helper'

RSpec.describe IngresoPorClasificarPolicy do
  let(:admin) { create :administrador }

  let(:cajero) { create :cajero, :con_contribuyente }
  let(:cierre_caja) { build :cierre_caja, cajero: cajero }
  let(:dinero) do
    build :dinero, dos_mil_pesos: 1, total: 2000
  end
  let(:arqueos) do
    create_list :arqueo, 5, cierre_caja: cierre_caja,
      dinero: dinero, monto_cajero: 2000, monto_sistema: 1000
  end

  subject { described_class }

  permissions ".scope" do
    before { arqueos }
    context "with cajero" do
      let(:policy_scope) { IngresoPorClasificarPolicy::Scope.new(cajero, IngresoPorClasificar).resolve }
      it "responds all ingresos por clasificar" do
        expect(policy_scope.count).to eq 5
      end
    end

    context "with admin" do
      let(:policy_scope) { IngresoPorClasificarPolicy::Scope.new(admin, IngresoPorClasificar).resolve }

      it "raise_error" do
        expect{ policy_scope }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end
end
