require "rails_helper"

RSpec.describe DatosLicenciaComercial, type: :model do
  it_behaves_like "datos licencia fields required"
  it { should validate_presence_of :fecha_refrendo }
end
