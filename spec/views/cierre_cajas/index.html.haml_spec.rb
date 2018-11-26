require 'rails_helper'

RSpec.describe "cierre_cajas/index", type: :view do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) do
    create :cajero,
      nombre: "Pedro",
      password: "qwerty",
      contribuyente: contribuyente
  end
  let(:dinero) { build :dinero, cincuenta_pesos: 1, total: 100 }
  let(:arqueo) do
    build :arqueo, monto_sistema: 100, monto_cajero: 50, dinero: dinero
  end
  before(:each) do
    assign(:cierre_cajas, Kaminari.paginate_array([
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
    ]).page(1))
  end

  it "renders a list of cierre_cajas" do
    render
    assert_select "tr>td", :text => "Abierta".to_s, :count => 2
    assert_select "tr>td", :text => "$50.00".to_s, :count => 2
    assert_select "tr>td", :text => "$100.00".to_s, :count => 2
  end
end
