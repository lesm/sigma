require 'rails_helper'

RSpec.describe IngresoPorClasificar, type: :model do
  it { should belong_to :cajero }
  it { should belong_to :arqueo }
  it { should validate_presence_of :monto }
end
