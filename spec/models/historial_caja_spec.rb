require "rails_helper"

RSpec.describe HistorialCaja, type: :model do
  it { should belong_to :caja }
  it { should belong_to :cajero }
end
