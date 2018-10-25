require 'rails_helper'

RSpec.describe Cajero, type: :model do
  it { should belong_to(:contribuyente) }
  it { should have_many(:cierre_cajas).dependent :destroy }
  it { should have_many(:arqueos).dependent :destroy }
  it { should have_many(:adeudos).dependent :destroy }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }
  it { should accept_nested_attributes_for(:contribuyente) }

  describe "#rol" do
    let(:contribuyente) do
      FactoryBot.create :contribuyente, :con_direccion
    end
    let(:cajero) do
      FactoryBot.create :cajero,
        contribuyente: contribuyente,
        rol: nil
    end
    it "after create must be 1" do
      expect(cajero.rol).to eq 1
    end
  end
end
