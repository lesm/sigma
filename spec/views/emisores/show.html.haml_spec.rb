require 'rails_helper'

RSpec.describe "emisores/show", type: :view do
  before(:each) do
    @emisor = assign(:emisor, Emisor.create!(
      :nombre => "Nombre",
      :numero_municipio => "482",
      :rfc => "AAA111111AAA",
      :regimen_fiscal => "Regimen Fiscal",
      :registro_patronal => "Registro Patronal",
      :eslogan => "Mi eslogan",
      :logotipo => fixture_file_upload("files/logotipo.png", "image/png"),
      :escudo => fixture_file_upload("files/escudo.png", "image/png"),
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/AAA111111AAA/)
    expect(rendered).to match(/Logo/)
    expect(rendered).to match(/Regimen Fiscal/)
    expect(rendered).to match(/Registro Patronal/)
    expect(rendered).to match(/Mi eslogan/)
  end
end
