require 'rails_helper'

RSpec.describe "emisores/index", type: :view do
  before(:each) do
    assign(:emisores, [
      Emisor.create!(
        :nombre => "Nombre",
        :numero_municipio => "482",
        :rfc => "AAA111111AAA",
        :logotipo => "Logo",
        :regimen_fiscal => "Regimen Fiscal",
        :registro_patronal => "Registro Patronal",
        :eslogan => "Lugar Expedicion"
      ),
      Emisor.create!(
        :nombre => "Nombre",
        :numero_municipio => "481",
        :rfc => "AAA111111AAA",
        :logotipo => "Logo",
        :regimen_fiscal => "Regimen Fiscal",
        :registro_patronal => "Registro Patronal",
        :eslogan => "Lugar Expedicion"
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
