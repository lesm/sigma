require "rails_helper"

RSpec.describe DatosPermisoCarga, type: :model do
  it { should validate_presence_of :fecha }
end
