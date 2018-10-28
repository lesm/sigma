require 'rails_helper'

RSpec.describe "cuentas/edit", type: :view do
  before(:each) do
    @cuenta = assign(:cuenta, Cuenta.create!(
      codigo: "110101",
      formato: "DatosComun",
      descripcion: "RIFAS",
      importe: 10.00
    ))
  end

  it "renders the edit cuenta form" do
    render

    assert_select "form[action=?][method=?]", cuenta_path(@cuenta), "post" do
      assert_select "input[name=?]", "cuenta[codigo]"
      assert_select "input[name=?]", "cuenta[descripcion]"
      assert_select "input[name=?]", "cuenta[importe]"
      assert_select "input[name=?]", "cuenta[formato]"
    end
  end
end
