require "rails_helper"

RSpec.describe DatosAgua, type: :model do
  it { should validate_presence_of :numero_contrato }
  it { should validate_presence_of :numero_medidor }
  it { should validate_presence_of :lectura_actual }
  it { should validate_presence_of :lectura_anterior }
  it { should validate_presence_of :consumo }
  it { should validate_presence_of :ruta }
  it { should validate_presence_of :lecturista }
  it { should validate_presence_of :fecha_corte }
end
