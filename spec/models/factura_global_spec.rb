require 'rails_helper'

RSpec.describe FacturaGlobal, type: :model do
  it { should have_many :recibos }
end
