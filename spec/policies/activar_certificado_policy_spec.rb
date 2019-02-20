require 'rails_helper'

RSpec.describe ActivarCertificadoPolicy do
  let(:caja) { create :caja }
  let(:admin) { create :administrador }
  let(:cajero) do
    create :cajero, :con_contribuyente, rol: 1, caja: caja
  end

  subject { described_class }

  permissions ".scope" do
    context "with admin" do
      let(:policy_scope) { ActivarCertificadoPolicy::Scope.new(admin, ActivarCertificado).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error NotImplementedError
      end
    end
    context "with cajero" do
      let(:policy_scope) { ActivarCertificadoPolicy::Scope.new(cajero, ActivarCertificado).resolve }
      it "raise_error" do
        expect{ policy_scope }.to raise_error NotImplementedError
      end
    end
  end

  permissions :new?, :create? do
    let(:activar_certificado) do
      build :activar_certificado
    end

    it "allows access to admin" do
      expect(subject).to permit(admin, activar_certificado)
    end

    it "denies acces to cajero" do
      expect(subject).to_not permit(cajero, activar_certificado)
    end
  end
end
