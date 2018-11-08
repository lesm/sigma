require "rails_helper"

RSpec.describe HistorialCaja, type: :model do
  it { should belong_to :caja }
  it { should belong_to :cajero }

  it { should validate_presence_of :caja_id }
end
