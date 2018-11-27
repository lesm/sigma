require "rails_helper"

RSpec.describe "historial_cajas/index", type: :view do
  let(:caja_uno) { create :caja, numero: 1 }
  let(:caja_dos) { create :caja, numero: 2 }
  let(:cajero_uno) do
    create :cajero, :con_contribuyente,
      nombre: "Pedro", caja: caja_uno
  end
  let(:cajero_dos) do
    create :cajero, :con_contribuyente,
      nombre: "José", caja: caja_dos
  end

  before :each do
    assign(:historial_cajas, Kaminari.paginate_array([
      HistorialCaja.create!(
        cajero: cajero_uno,
        caja: caja_uno,
        fecha_cierre: nil
      ),
      HistorialCaja.create!(
        cajero: cajero_dos,
        caja: caja_dos,
        fecha_cierre: nil
      )
    ]).page(1))
  end

  it "renders a list of arqueos" do
    render
    assert_select "tr>td", :text => "José".to_s, :count => 1
    assert_select "tr>td", :text => "Pedro".to_s, :count => 1
  end
end
