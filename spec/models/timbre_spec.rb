require 'rails_helper'

RSpec.describe Timbre, type: :model do
  it { should belong_to :comprobante }
end
