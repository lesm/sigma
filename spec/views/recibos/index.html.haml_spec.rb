require 'rails_helper'

RSpec.describe "recibos/index", type: :view do
  let(:caja) { create :caja }
  let(:recibo) { create :recibo, :con_datos, folio: "1", caja: caja }
  let(:recibo_dos) { create :recibo, :con_datos, folio: "2", caja: caja }

  before(:each) do
    assign(:recibos, Kaminari.paginate_array([
      recibo,
      recibo_dos
    ]).page(1))
  end

  it "renders a list of recibos" do
    render

    assert_select "tr>td", :text => "1".to_s, :count => 1
    assert_select "tr>td", :text => "2".to_s, :count => 1
  end
end
