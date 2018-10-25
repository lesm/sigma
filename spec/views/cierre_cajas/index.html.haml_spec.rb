require 'rails_helper'

RSpec.describe "cierre_cajas/index", type: :view do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) do
    create :cajero,
      nombre: "Pedro",
      password: "qwerty",
      contribuyente: contribuyente
  end
  let(:arqueo) do
    build :arqueo, monto_sistema: 9.99, monto_cajero: 9.99
  end
  before(:each) do
    assign(:cierre_cajas, [
      CierreCaja.create!(
        :observacion => "MyText",
        :cajero => cajero,
        :arqueos => [arqueo]
      ),
      CierreCaja.create!(
        :observacion => "MyText",
        :cajero => cajero,
        :arqueos => [arqueo]
      )
    ])
  end

  it "renders a list of cierre_cajas" do
    render
    assert_select "tr>td", :text => "Abierta".to_s, :count => 2
    assert_select "tr>td", :text => "$0.00".to_s, :count => 2
  end
end
