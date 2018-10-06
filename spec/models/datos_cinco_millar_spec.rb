require "rails_helper"

RSpec.describe DatosCincoMillar, type: :model do
  it { should validate_presence_of :fecha }
  it { should validate_presence_of :localidad }
  it { should validate_presence_of :estimacion }
  it { should validate_presence_of :nombre_obra }
end
