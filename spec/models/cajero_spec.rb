require 'rails_helper'

RSpec.describe Cajero, type: :model do
  it { should have_one(:contribuyente).dependent :destroy }
  it { should have_many(:cierre_cajas).dependent :destroy }
  it { should have_many(:arqueos).dependent :destroy }
  it { should have_many(:adeudos).dependent :destroy }
  it { should accept_nested_attributes_for(:contribuyente) }

  describe "#rol" do
    it "after create must be 1" do
      cajero = FactoryBot.create :cajero, rol: nil
      expect(cajero.rol).to eq 1
    end
  end
end
