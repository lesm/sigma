require 'rails_helper'

RSpec.describe "emisores/show", type: :view do
  before(:each) do
    @emisor = assign(:emisor, Emisor.create!(
      :nombre => "Nombre",
      :rfc => "AAA111111AAA",
      :logo => "Logo",
      :regimen_fiscal => "Regimen Fiscal",
      :registro_patronal => "Registro Patronal",
      :lugar_expedicion => "Lugar Expedicion"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/AAA111111AAA/)
    expect(rendered).to match(/Logo/)
    expect(rendered).to match(/Regimen Fiscal/)
    expect(rendered).to match(/Registro Patronal/)
    expect(rendered).to match(/Lugar Expedicion/)
  end
end
