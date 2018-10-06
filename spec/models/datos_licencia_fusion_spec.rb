require "rails_helper"

RSpec.describe DatosLicenciaFusion, type: :model do
  it { should validate_presence_of :folio }
  it { should validate_presence_of :serie }
  it { should validate_presence_of :fecha }
end

