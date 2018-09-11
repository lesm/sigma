require 'rails_helper'

RSpec.describe CierreCaja, type: :model do
  it { should validate_presence_of(:monto) }
  it { should belong_to(:usuario) }
end
