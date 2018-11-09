require 'rails_helper'

RSpec.describe "cuentas/show", type: :view do
  before(:each) do
    sign_in_cajero
    @cuenta = assign(:cuenta, Cuenta.create!(
      codigo: "110101",
      formato: "DatosComun",
      descripcion: "RIFAS",
      importe: 10.00
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/110101/)
    expect(rendered).to match(/RIFAS/)
  end
end
