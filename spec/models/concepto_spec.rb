require 'rails_helper'

RSpec.describe Concepto, type: :model do
  it { should validate_presence_of :importe }
  it { should belong_to :cuenta }
  it { should have_one(:datos_concepto).dependent(:destroy) }
  it { should accept_nested_attributes_for(:datos_concepto).allow_destroy(true) }
end
