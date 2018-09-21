require 'rails_helper'

RSpec.describe Dinero, type: :model do
  it { should belong_to :arqueo }
  it { should_not allow_value(-1).for :diez_centavos }
  it { should_not allow_value(-1).for :veinte_centavos }
  it { should_not allow_value(-1).for :cincuenta_centavos }
  it { should_not allow_value(-1).for :un_peso }
  it { should_not allow_value(-1).for :dos_pesos }
  it { should_not allow_value(-1).for :cinco_pesos }
  it { should_not allow_value(-1).for :diez_pesos }
  it { should_not allow_value(-1).for :veinte_pesos }
  it { should_not allow_value(-1).for :cincuenta_pesos }
  it { should_not allow_value(-1).for :cien_pesos }
  it { should_not allow_value(-1).for :doscientos_pesos }
  it { should_not allow_value(-1).for :quinientos_pesos }
  it { should_not allow_value(-1).for :mil_pesos }
  it { should_not allow_value(-1).for :dos_mil_pesos }
  it { should_not allow_value(-1).for :total }
end
