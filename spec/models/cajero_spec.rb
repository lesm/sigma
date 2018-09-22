require 'rails_helper'

RSpec.describe Cajero, type: :model do
  it { should have_many(:cierre_cajas).dependent :destroy }
  it { should have_many(:arqueos).dependent :destroy }
end

