require 'rails_helper'

RSpec.describe "contribuyentes/show", type: :view do
  let(:rifas) { create :cuenta, :rifas }

  before(:each) do
    @contribuyente = assign(:contribuyente, Contribuyente.create!(
      :nombre_o_razon_social => "Pedro",
      :primer_apellido => "Pérez",
      :segundo_apellido => "Pérez",
      :persona_fisica => true,
      :email => "pedro@gmail.com",
      :rfc => "AAAA111111AAA",
      :concepto_ids => [rifas.id]
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Pedro/)
    expect(rendered).to match(/Pérez/)
    expect(rendered).to match(/Persona Física/)
    expect(rendered).to match(/AAAA111111AAA/)
  end
end
