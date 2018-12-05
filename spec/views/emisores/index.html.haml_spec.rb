require 'rails_helper'

RSpec.describe "emisores/index", type: :view do
  before(:each) do
    assign(:emisores, [
      Emisor.create!(
        :nombre => "Nombre",
        :numero_municipio => "482",
        :rfc => "AAA111111AAA",
        :regimen_fiscal => "Regimen Fiscal",
        :registro_patronal => "Registro Patronal",
        :eslogan => "Lugar Expedicion",
        :logotipo => fixture_file_upload("files/logotipo.png", "image/png"),
        :escudo => fixture_file_upload("files/escudo.png", "image/png"),
      ),
      Emisor.create!(
        :nombre => "Nombre",
        :numero_municipio => "481",
        :rfc => "AAA111111AAA",
        :regimen_fiscal => "Regimen Fiscal",
        :registro_patronal => "Registro Patronal",
        :eslogan => "Lugar Expedicion",
        :logotipo => fixture_file_upload("files/logotipo.png", "image/png"),
        :escudo => fixture_file_upload("files/escudo.png", "image/png"),
      )
    ])
  end

  it "renders a list of emisores" do
    render
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "AAA111111AAA".to_s, :count => 2
    assert_select "tr>td", :text => "Regimen Fiscal".to_s, :count => 2
  end
end
