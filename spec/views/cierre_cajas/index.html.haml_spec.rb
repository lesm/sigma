require 'rails_helper'

RSpec.describe "cierre_cajas/index", type: :view do
  let(:usuario) { FactoryBot.create :usuario, nombre: "Pedro", password: "qwerty" }
  before(:each) do
    assign(:cierre_cajas, [
      CierreCaja.create!(
        :monto => "9.99",
        :observacion => "MyText",
        :usuario => usuario
      ),
      CierreCaja.create!(
        :monto => "9.99",
        :observacion => "MyText",
        :usuario => usuario
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
