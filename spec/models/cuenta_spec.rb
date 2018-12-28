require 'rails_helper'

RSpec.describe Cuenta, type: :model do
  it { should have_many :conceptos }

  it { should validate_presence_of :descripcion }
  it { should validate_presence_of :codigo }
  it { should validate_presence_of :clave_producto }
  it { should validate_presence_of :clave_unidad }
  it { should validate_presence_of :codigo }
  it { should validate_length_of(:codigo).is_equal_to(6) }
  it { should have_and_belong_to_many :contribuyentes }
  context "uniqueness" do
    subject { build :cuenta }
    it { should validate_uniqueness_of(:descripcion).case_insensitive }
  end

  describe "Uniqueness" do
    let(:contribuyente) { create :contribuyente, :con_direccion }
    let(:cuenta) { create :cuenta, :rifas }

    before :each do
      cuenta.contribuyentes << contribuyente
    end

    it "not add relationship" do
      cuenta.contribuyentes << contribuyente
      expect(cuenta.reload.contribuyentes.count).to eq 1
    end
  end

  describe ".search" do
    let(:rifa) do
      create :cuenta, codigo: "110101",
        descripcion: "110101 - RIFAS",
        clave_producto: "93161700 - Administración tributaria"
    end
    let(:sorteo) do
      create :cuenta, codigo: "110102",
        descripcion: "110102 - SORTEOS",
        clave_producto: "93161700 - Administración tributaria"
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
