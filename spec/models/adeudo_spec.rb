require 'rails_helper'

RSpec.describe Adeudo, type: :model do
  it { should validate_presence_of :monto }
  it { should belong_to :cajero }
  it { should belong_to :arqueo }
end
