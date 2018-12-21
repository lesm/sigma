require "rails_helper"

RSpec.describe DatosPredial, type: :model do
  it { should validate_presence_of :folio }
  it { should validate_presence_of :clave_catastral }
  it { should validate_presence_of :fecha }
  it { should validate_presence_of :numero_cuenta }
  it { should validate_presence_of :ubicacion }
  it { should validate_presence_of :base_catastral }
  it { should validate_presence_of :impuesto_predial }
  it { should validate_presence_of :years }
end
