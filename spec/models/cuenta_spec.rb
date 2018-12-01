require 'rails_helper'

RSpec.describe Cuenta, type: :model do
  it { should have_many :conceptos }

  it { should validate_presence_of :descripcion }
  it { should validate_presence_of :codigo }
  it { should validate_length_of(:codigo).is_equal_to(6) }
  context "uniqueness" do
    subject { build :cuenta }
    it { should validate_uniqueness_of(:descripcion).case_insensitive }
  end

  describe ".search" do
    let(:rifa) do
      create :cuenta, codigo: "110101",
        descripcion: "RIFAS"
    end
    let(:sorteo) do
      create :cuenta, codigo: "110102",
        descripcion: "SORTEOS"
    end

    before :each do
      [rifa, sorteo]
    end

    context "when search for codigo '110101'" do
      it "returns 1 coincidence" do
        expect(Cuenta.search("110101").count).to eq 1
      end

      it "returns 1 coincidence" do
        expect(Cuenta.search("RiFaS").count).to eq 1
      end
    end

    context "when search for codigo '110102'" do
      it "returns 1 coincidence" do
        expect(Cuenta.search("110102").count).to eq 1
      end

      it "returns 1 coincidence" do
        expect(Cuenta.search("SorTeO").count).to eq 1
      end
    end
  end
end
