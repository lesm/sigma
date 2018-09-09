require 'rails_helper'

RSpec.describe Direccion, type: :model do
  it { should validate_presence_of(:calle) }
  it { should validate_presence_of(:colonia) }
  it { should validate_presence_of(:codigo_postal) }
  it { should validate_presence_of(:localidad) }
  it { should validate_presence_of(:municipio) }
  it { should validate_presence_of(:estado) }
  it { should validate_presence_of(:pais) }
end
