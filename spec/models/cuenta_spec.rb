require 'rails_helper'

RSpec.describe Cuenta, type: :model do
  it { should validate_presence_of :descripcion }
  it { should validate_presence_of :codigo }
  context "uniqueness" do
    subject  { build :cuenta, codigo: '123212', descripcion: "hola" }
    it { should validate_uniqueness_of(:codigo).case_insensitive }
  end
  it { should validate_length_of(:codigo).is_equal_to(6) }
end
