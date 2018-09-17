require 'rails_helper'

RSpec.describe "cierre_cajas/show", type: :view do
  let(:usuario) { FactoryBot.create :usuario, nombre: "Pedro", password: "qwerty" }
  let(:arqueo) { FactoryBot.build :arqueo, monto: 9.99 }
  before(:each) do
    @cierre_caja = assign(:cierre_caja, CierreCaja.create!(
      :monto => "9.99",
      :observacion => "MyText",
      :usuario => usuario,
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
