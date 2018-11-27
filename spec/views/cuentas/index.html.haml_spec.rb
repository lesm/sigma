require 'rails_helper'

RSpec.describe "cuentas/index", type: :view do
  before(:each) do
    sign_in_cajero
    assign(:cuentas, Kaminari.paginate_array([
      Cuenta.create!(
        codigo: "110101",
        formato: "DatosComun",
        descripcion: "RIFAS",
        importe: 10.00
      ),
      Cuenta.create!(
        codigo: "110101",
        formato: "DatosComun",
        descripcion: "RIFAS DEL MUNICIPIO",
        importe: 10.00
      )
    ]).page(1))
  end

  it "renders a list of cuentas" do
    render
    assert_select "tr>td", :text => "110101".to_s, :count => 2
  end
end
