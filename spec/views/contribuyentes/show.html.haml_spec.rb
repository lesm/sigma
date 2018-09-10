require 'rails_helper'

RSpec.describe "contribuyentes/show", type: :view do
  before(:each) do
    @contribuyente = assign(:contribuyente, Contribuyente.create!(
      :nombre_o_razon_social => "Pedro",
      :primer_apellido => "Pérez",
      :segundo_apellido => "Pérez",
      :persona_fisica => true,
      :email => "pedro@gmail.com",
      :rfc => "AAAA111111AAA",
      direccion_attributes: {
        :calle => "Independencia",
        :numero => "1",
        :colonia => "Centro",
        :codigo_postal => "68000",
        :localidad => "Oaxaca",
        :municipio => "Oaxaca",
        :estado => "Oaxaca",
        :pais => "México"
      }
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Pedro/)
    expect(rendered).to match(/Pérez/)
    expect(rendered).to match(/true/)
    expect(rendered).to match(/pedro@gmail.com/)
    expect(rendered).to match(/AAAA111111AAA/)
    expect(rendered).to match(/Independencia/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Centro/)
    expect(rendered).to match(/68000/)
    expect(rendered).to match(/Oaxaca/)
    expect(rendered).to match(/México/)
  end
end
