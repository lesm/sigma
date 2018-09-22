require 'rails_helper'

RSpec.describe "arqueos/show", type: :view do
  let(:cajero) { FactoryBot.create :cajero }
  let(:cierre_caja) { FactoryBot.create :cierre_caja, cajero: cajero }
  before(:each) do
    @arqueo = assign(:arqueo, Arqueo.create!(
      :monto_sistema => "9.99",
      :monto_cajero => "9.99",
      :observacion => "MyText",
      :cierre_caja => cierre_caja
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
  end
end
