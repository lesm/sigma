require 'rails_helper'

RSpec.describe "cierre_cajas/edit", type: :view do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) do
    create :cajero,
      nombre: "Pedro",
      password: "qwerty",
      contribuyente: contribuyente
  end
  before(:each) do
    @cierre_caja = assign(:cierre_caja, CierreCaja.create!(
      :monto_sistema => "9.99",
      :monto_cajero => "9.99",
      :observacion => "MyText",
      :cajero => cajero
    ))
  end

  it "renders the edit cierre_caja form" do
    render

    assert_select "form[action=?][method=?]", cierre_caja_path(@cierre_caja), "post" do

      assert_select "input[name=?]", "cierre_caja[monto_cajero]"

      assert_select "textarea[name=?]", "cierre_caja[observacion]"

      assert_select "input[name=?]", "cierre_caja[cajero_id]"
    end
  end
end
