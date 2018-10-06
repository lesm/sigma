require 'rails_helper'

RSpec.describe "recibos/index", type: :view do
  let(:recibo) { create :recibo, :con_datos, folio: "1" }
  let(:recibo_dos) { create :recibo, :con_datos, folio: "2" }

  before(:each) do
    assign(:recibos, [
      recibo,
      recibo_dos
    ])
  end

  it "renders a list of recibos" do
    render

    assert_select "tr>td", :text => "1".to_s, :count => 1
    assert_select "tr>td", :text => "2".to_s, :count => 1
  end
end
