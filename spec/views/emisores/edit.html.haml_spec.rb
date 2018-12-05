require 'rails_helper'

RSpec.describe "emisores/edit", type: :view do
  before(:each) do
    @emisor = assign(:emisor, Emisor.create!(
      :nombre => "MyString",
      :numero_municipio => "482",
      :rfc => "AAA111111AAA",
      :regimen_fiscal => "MyString",
      :registro_patronal => "MyString",
      :eslogan => "MyString",
      :logotipo => fixture_file_upload("files/logotipo.png", "image/png"),
      :escudo => fixture_file_upload("files/escudo.png", "image/png"),
    ))
  end

  it "renders the edit emisor form" do
    render

    assert_select "form[action=?][method=?]", emisor_path(@emisor), "post" do
      assert_select "input[name=?]", "emisor[nombre]"
      assert_select "input[name=?]", "emisor[rfc]"
      assert_select "input[name=?]", "emisor[logotipo]"
      assert_select "input[name=?]", "emisor[regimen_fiscal]"
      assert_select "input[name=?]", "emisor[registro_patronal]"
      assert_select "input[name=?]", "emisor[eslogan]"
    end
  end
end
