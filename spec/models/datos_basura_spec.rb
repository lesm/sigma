require 'rails_helper'

RSpec.describe DatosBasura, type: :model do
  it { should validate_presence_of :fecha }
end


