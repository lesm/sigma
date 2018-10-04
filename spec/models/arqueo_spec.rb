require 'rails_helper'

RSpec.describe Arqueo, type: :model do
  it { should belong_to :cierre_caja }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }
  it { should have_one(:dinero).dependent(:destroy) }
  it { should have_one(:adeudo).dependent(:destroy) }
  it { should accept_nested_attributes_for(:dinero).allow_destroy(true) }
  it { should validate_presence_of :monto_cajero }
  it { should_not allow_value(-1).for :monto_cajero }
  it { should_not allow_value(0).for :monto_cajero }
  it { should allow_value(10.5).for :monto_cajero }
end
