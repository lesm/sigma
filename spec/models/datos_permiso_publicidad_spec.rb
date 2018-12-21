require 'rails_helper'

RSpec.describe DatosPermisoPublicidad, type: :model do
  it { should validate_presence_of :fecha }
  it { should validate_presence_of :years }
end
