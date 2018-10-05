require 'rails_helper'

RSpec.describe Concepto, type: :model do
  it { should validate_presence_of :importe }
  it { should belong_to :cuenta }
end
