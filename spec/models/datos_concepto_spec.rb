require 'rails_helper'

RSpec.describe DatosConcepto, type: :model do
  it { should belong_to :concepto }
end
