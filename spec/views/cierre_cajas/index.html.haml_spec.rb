require 'rails_helper'

RSpec.describe "cierre_cajas/index", type: :view do
  let(:usuario) { FactoryBot.create :usuario, nombre: "Pedro", password: "qwerty" }
  let(:arqueo) { FactoryBot.build :arqueo, monto_sistema: 9.99, monto_cajero: 9.99 }
  before(:each) do
    assign(:cierre_cajas, [
      CierreCaja.create!(
        :observacion => "MyText",
        :usuario => usuario,
        :arqueos => [arqueo]
      ),
      CierreCaja.create!(
        :observacion => "MyText",
        :usuario => usuario,
        :arqueos => [arqueo]
      )
    ])
  end

  it "renders a list of cierre_cajas" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => usuario.nombre.to_s, :count => 2
  end
end
