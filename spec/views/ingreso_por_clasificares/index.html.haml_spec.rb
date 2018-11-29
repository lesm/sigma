require 'rails_helper'

RSpec.describe "ingreso_por_clasificares/index", type: :view do
  let(:cajero) { create :cajero, :con_contribuyente }
  let(:arqueo) do
    build :arqueo, monto_sistema: 1000,
      monto_cajero: 2000
  end
  let(:cierre_caja) do
    create :cierre_caja, arqueos: [arqueo],
      monto_sistema: 1000, monto_cajero: 2000, cajero: cajero
  end

  before(:each) do
    cierre_caja
    assign(:ingresos, Kaminari.paginate_array([
      IngresoPorClasificar.create!(
        monto: 1000,
        cajero: cajero,
        arqueo: arqueo
      ),
      IngresoPorClasificar.create!(
        monto: 1000,
        cajero: cajero,
        arqueo: arqueo
      ),
    ]).page(1))
  end

  it "renders a list of ingresos por clasificar" do
    render
    assert_select "tr>td", :text => "$1,000.00".to_s, :count => 2
    assert_select "tr>td>a", :text => "Ver".to_s, :count => 2
  end
end
