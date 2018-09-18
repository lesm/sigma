require 'rails_helper'

RSpec.describe "cierre_cajas/edit", type: :view do
  let(:usuario) { FactoryBot.create :usuario, nombre: "Pedro", password: "qwerty" }
  before(:each) do
    @cierre_caja = assign(:cierre_caja, CierreCaja.create!(
      :monto_sistema => "9.99",
      :monto_cajero => "9.99",
      :observacion => "MyText",
      :usuario => usuario
    ))
  end

  it "renders the edit cierre_caja form" do
    render

    assert_select "form[action=?][method=?]", cierre_caja_path(@cierre_caja), "post" do

      assert_select "input[name=?]", "cierre_caja[monto_cajero]"

      assert_select "textarea[name=?]", "cierre_caja[observacion]"

      assert_select "input[name=?]", "cierre_caja[usuario_id]"
    end
  end
end
