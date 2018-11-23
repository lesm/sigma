require 'rails_helper'

RSpec.describe ReciboStepPolicy do
  let(:user) { User.new }
  let(:admin) { create :usuario, :admin }
  let(:cajero) { create :cajero, :con_contribuyente }

  subject { described_class }

  permissions :show?, :update? do
    it "allow access to cajero" do
      expect(subject).to permit(cajero, ReciboStep.new)
    end

    it "denies access to admin" do
      expect(subject).to_not permit(admin, ReciboStep.new)
    end
  end
end
