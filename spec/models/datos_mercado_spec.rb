require "rails_helper"

RSpec.describe DatosMercado, type: :model do
  it { validate_presence_of :cantidad_folios_cinco }
  it { validate_presence_of :cantidad_folios_diez }
  it { validate_presence_of :responsable }
  it { validate_presence_of :fecha }
end
