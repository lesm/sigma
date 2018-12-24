require "rails_helper"

RSpec.describe "historial_cajas/index", type: :view do
  let(:contribuyente) do
    create :contribuyente, :con_direccion, nombre_o_razon_social: "Pedro",
      primer_apellido: "Pérez", persona_fisica: true
  end
  let(:contribuyente_dos) do
    create :contribuyente, :con_direccion, nombre_o_razon_social: "Carlos",
      primer_apellido: "Zafran", persona_fisica: true
  end

  let(:caja_uno) { create :caja, numero: 1 }
  let(:caja_dos) { create :caja, numero: 2 }
  let(:cajero_uno) do
    create :cajero, nombre: "Pedro Pérez",
      caja: caja_uno, contribuyente: contribuyente
  end
  let(:cajero_dos) do
    create :cajero, nombre: "Carlos Zafran",
      caja: caja_dos, contribuyente: contribuyente_dos
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
    assert_select "tr>td", :text => "Pedro Pérez".to_s, :count => 1
    assert_select "tr>td", :text => "Carlos Zafran".to_s, :count => 1
  end
end
