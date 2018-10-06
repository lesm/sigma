require 'rails_helper'

RSpec.describe "recibos/show", type: :view do
  let(:recibo) { create :recibo, :con_datos, folio: "1" }

  before(:each) do
    @recibo = assign(:recibo, recibo)
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(/1/)
  end
end
