require "rails_helper"

RSpec.describe DatosMultaTransito, type: :model do
  it { should  validate_presence_of :fecha }
  it { should  validate_presence_of :folio }
  it { should  validate_presence_of :placa }
end
