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
end
