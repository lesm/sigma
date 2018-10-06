require 'rails_helper'

RSpec.describe DatosPadronContratista, type: :model do
  it { should validate_presence_of :fecha }
  it { should validate_presence_of :nombre_contratista }
end



