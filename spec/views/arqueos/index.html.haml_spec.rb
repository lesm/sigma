require 'rails_helper'

RSpec.describe "arqueos/index", type: :view do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) { create :cajero, contribuyente: contribuyente }
  let(:cierre_caja) do
    create :cierre_caja, cajero: cajero
  end
  before(:each) do
    assign(:arqueos, [
      Arqueo.create!(
        :monto_sistema => "9.99",
        :monto_cajero => "9.99",
        :observacion => "MyText",
        :cierre_caja => cierre_caja
      ),
      Arqueo.create!(
        :monto_sistema => "9.99",
        :monto_cajero => "9.99",
        :observacion => "MyText",
        :cierre_caja => cierre_caja
      )
    ])
  end

  it "renders a list of arqueos" do
    render
    assert_select "tr>td", :text => "$9.99".to_s, :count => 4
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
