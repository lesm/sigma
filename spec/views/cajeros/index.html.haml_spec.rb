require 'rails_helper'

RSpec.describe "cajeros/index", type: :view do
  let(:contribuyente_uno) do
    create :contribuyente, :con_direccion, rfc: "AAAA111111AAB"
  end
  let(:contribuyente_dos) do
    create :contribuyente, :con_direccion, rfc: "AAAA111111AAC"
  end
  before(:each) do
    assign(:cajeros, [
      Cajero.create!(
        nombre: "Cajero",
        username: "cajerito",
        password: "1qaz2wsx",
        activo: true,
        rol: 1,
        contribuyente_id: contribuyente_uno.id
      ),
      Cajero.create!(
        nombre: "Cajero",
        username: "cajerote",
        password: "1qaz2wsx",
        activo: true,
        rol: 1,
        contribuyente_id: contribuyente_dos.id
      ),
    ])
  end

  it "renders a list of cajeros" do
    render
    assert_select "tr>td", :text => "Cajero".to_s, :count => 2
    assert_select "tr>td", :text => "cajerito".to_s, :count => 1
    assert_select "tr>td", :text => "cajerote".to_s, :count => 1
  end
end
