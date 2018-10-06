require 'rails_helper'

RSpec.describe DatosComun, type: :model do
  it { should validate_presence_of :fecha }
end
