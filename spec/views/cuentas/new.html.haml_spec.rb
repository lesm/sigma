require 'rails_helper'

RSpec.describe "cuentas/new", type: :view do
  before(:each) do
    assign(:cuenta, Cuenta.new(
      codigo: "110101",
      formato: "DatosComun",
      descripcion: "RIFAS",
      importe: 10.00
    ))
  end

  it "renders new cuenta form" do
    render

    assert_select "form[action=?][method=?]", cuentas_path, "post" do
      assert_select "input[name=?]", "cuenta[descripcion]"
      assert_select "input[name=?]", "cuenta[importe]"
      assert_select "input[name=?]", "cuenta[formato]"
    end
  end
end
