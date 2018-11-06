require 'rails_helper'

RSpec.describe Emisor, type: :model do
  it { should validate_presence_of(:nombre) }
  it { should validate_uniqueness_of(:numero_municipio) }
  it { should validate_presence_of(:numero_municipio) }
  it { should_not allow_value("hola").for(:numero_municipio) }
  it { should validate_presence_of(:rfc) }
  it { should validate_presence_of(:regimen_fiscal) }
  it { should have_one(:direccion).dependent(:destroy) }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }
  it { should accept_nested_attributes_for(:direccion).allow_destroy(true)}

  describe "rfc valido" do
    subject { FactoryBot.build :emisor, rfc: 'AAAA111111AAA' }
    it "debe ser 12 caracteres" do
      expect(subject).to_not be_valid
      expect(subject.errors.to_a.to_sentence).to match /debe ser de 12 caracteres/
    end
  end
end
