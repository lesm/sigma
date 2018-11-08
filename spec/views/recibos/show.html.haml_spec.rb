require 'rails_helper'

RSpec.describe "recibos/show", type: :view do
  let(:caja) { create :caja }
  let(:recibo) { create :recibo, :con_datos, folio: "1", caja: caja }

  before(:each) do
    @recibo = assign(:recibo, recibo)
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/1/)
  end
end
