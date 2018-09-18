require 'rails_helper'

RSpec.describe "cierre_cajas/new", type: :view do
  before(:each) do
    assign(:cierre_caja, CierreCaja.new(
      :monto_sistema => "9.99",
      :monto_cajero => "9.99",
      :observacion => "MyText",
      :usuario => nil
    ))
  end

  it "renders new cierre_caja form" do
    render

    assert_select "form[action=?][method=?]", cierre_cajas_path, "post" do

      assert_select "input[name=?]", "cierre_caja[monto_cajero]"

      assert_select "textarea[name=?]", "cierre_caja[observacion]"

      assert_select "input[name=?]", "cierre_caja[usuario_id]"
    end
  end
end
