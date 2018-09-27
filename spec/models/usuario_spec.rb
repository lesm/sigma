require 'rails_helper'

RSpec.describe Usuario, type: :model do
  it { should validate_presence_of(:nombre) }
  it { should validate_presence_of(:username) }

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
end
