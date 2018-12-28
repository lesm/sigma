require 'rails_helper'

RSpec.describe "cuentas/index", type: :view do
  before(:each) do
    sign_in_cajero
    assign(:cuentas, Kaminari.paginate_array([
      Cuenta.create!(
        codigo: "110101",
        formato: "DatosComun",
        descripcion: "110101 - RIFAS",
        importe: 10.00,
        clave_producto: "93161700 - Administración tributaria",
        clave_unidad: "E48 - Unidad de servicio"
      ),
      Cuenta.create!(
        codigo: "110101",
        formato: "DatosComun",
        descripcion: "110101 - RIFAS DEL MUNICIPIO",
        importe: 10.00,
        clave_producto: "93161700 - Administración tributaria",
        clave_unidad: "E48 - Unidad de servicio"
      )
    ]).page(1))
  end

  it "renders a list of cuentas" do
    render
    assert_select "tr>td", :text => "110101".to_s, :count => 2
  end
end
