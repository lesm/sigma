require "rails_helper"

RSpec.describe DatosMultaAdministrativa, type: :model do
  it { should validate_presence_of :fecha }
end
