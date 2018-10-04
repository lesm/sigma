require 'rails_helper'

RSpec.describe "cajeros/show", type: :view do
  let(:direccion) do
    {
      calle: "una calee",
      numero: "s/n",
      colonia: "una colonia",
      codigo_postal: "68300",
      localidad: "una localida",
      municipio: "un municipio",
      estado: "Oaxaca",
      pais: "México"
    }
  end
  let(:contribuyente) do
    {
      nombre_o_razon_social: "Carlos",
      primer_apellido: "Pérez",
      segundo_apellido: "Pérez",
      persona_fisica: true,
      email: "pedro@gmail.com",
      rfc: "AAAA111111AAA",
      direccion_attributes: direccion,
    }
  end

  before(:each) do
    @cajero = assign(:cajero, Cajero.create!(
      nombre: "Carlos", username: "carlos", password: "1qaz2wsx",
      contribuyente_attributes: contribuyente 
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Carlos/)
    expect(rendered).to match(/carlos/)
  end
end
