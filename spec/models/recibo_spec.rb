require 'rails_helper'

RSpec.describe Recibo, type: :model do
  it { should belong_to :factura_global }

  describe ".sin_factura_global" do
    let(:factura_global) { create :factura_global, :con_relaciones }
    let!(:recibo_sin_factura_global) do
      create :recibo, :para_timbrar, factura_global_id: nil
    end
    let!(:recibo_con_factura_global) do
      create :recibo, :para_timbrar, factura_global: factura_global
    end

    it "returns when factura_global_id is nil" do
      expect(Recibo.sin_factura_global).to eq [recibo_sin_factura_global]
    end
  end

end
