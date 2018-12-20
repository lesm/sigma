require 'rails_helper'

RSpec.describe Administrador, type: :model do
  describe "#rol" do
    let(:admin) do
      FactoryBot.create :administrador,
        rol: nil
    end

    it "after create must be admin rol" do
      expect(admin).to be_admin
    end
  end
end
