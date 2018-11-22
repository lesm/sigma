require 'rails_helper'

RSpec.describe HistorialCajaPolicy do
  let(:admin) { create :usuario, rol: 3 }
  let(:cajero) { create :cajero, :con_contribuyente, rol: 1 }

  subject { described_class }

  permissions :index? do
    it "does not allow cajero to visit index" do
      expect(subject).to_not permit(cajero, HistorialCaja.new)
    end

    it "allow admin to visit index" do
      expect(subject).to permit(admin, HistorialCaja.new)
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
