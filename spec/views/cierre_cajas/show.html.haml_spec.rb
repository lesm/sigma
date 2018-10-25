require 'rails_helper'

RSpec.describe "cierre_cajas/show", type: :view do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) do
    create :cajero,
      nombre: "Pedro",
      password: "qwerty",
      contribuyente: contribuyente
  end
  let(:arqueo) do
    build :arqueo, monto_sistema: 9.99, monto_cajero: 9.99
  end
  before(:each) do
    @cierre_caja = assign(:cierre_caja, CierreCaja.create!(
      :monto_sistema => "9.99",
      :monto_cajero => "9.99",
      :observacion => "MyText",
      :cajero => cajero,
      :arqueos => [arqueo]
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Pedro/)
  end
end
