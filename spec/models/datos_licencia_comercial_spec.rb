require "rails_helper"

RSpec.describe DatosLicenciaComercial, type: :model do
  it { should validate_presence_of :fecha }
  it { should validate_presence_of :fecha_refrendo }
  it { should validate_presence_of :serie }
  it { should validate_presence_of :folio }
end
