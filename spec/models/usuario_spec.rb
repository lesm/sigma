require 'rails_helper'

RSpec.describe Usuario, type: :model do
  it { should validate_presence_of(:nombre) }
  it { should validate_presence_of(:username) }

  describe "Uniqueness of #username" do
    subject { build :usuario, username: "Cortazar" }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  let(:usuario) { create :usuario }

  describe "#active_for_authentication?" do
    it "returns true when activo is true" do
      usuario = FactoryBot.build :usuario, activo: true
      expect(usuario.active_for_authentication?).to eq true
    end

    it "returns false when activo is false" do
      usuario = FactoryBot.build :usuario, activo: false
      expect(usuario.active_for_authentication?).to eq false
    end
  end

  describe "#sin_arqueo?" do
    it "is false" do
      expect(usuario).to_not be_sin_arqueo
    end
  end

  describe "#caja" do
    it "is nil" do
      expect(usuario.caja).to be_nil
    end
  end

  describe "#cierre_caja_id" do
    it "is nil" do
      expect(usuario.cierre_caja_id).to be_nil
    end
  end

  describe "#cierre_caja_abierta?" do
    it "is false" do
      expect(usuario).to_not be_cierre_caja_abierta
    end
  end

  describe "#arqueo_pendiente?" do
    it "is false" do
      expect(usuario).to_not be_arqueo_pendiente
    end
  end

  describe "#monto_no_efectivo" do
    it "is nil" do
      expect(usuario.monto_no_efectivo).to be_nil
    end
  end

  describe "#monto_sistema" do
    it "is nil" do
      expect(usuario.monto_sistema).to be_nil
    end
  end
end
