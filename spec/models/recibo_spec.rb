require 'rails_helper'

RSpec.describe Recibo, type: :model do
  it { should belong_to :factura_global }
end
