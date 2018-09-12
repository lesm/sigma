require 'rails_helper'

RSpec.describe "emisores/new", type: :view do
  before(:each) do
    assign(:emisor, Emisor.new(
      :nombre => "MyString",
      :rfc => "MyString",
      :logotipo => "MyString",
      :regimen_fiscal => "MyString",
      :registro_patronal => "MyString",
      :eslogan => "MyString"
    ))
  end

  it "renders new emisor form" do
    render

    assert_select "form[action=?][method=?]", emisores_path, "post" do
      assert_select "input[name=?]", "emisor[nombre]"
      assert_select "input[name=?]", "emisor[rfc]"
      assert_select "input[name=?]", "emisor[logotipo]"
      assert_select "input[name=?]", "emisor[regimen_fiscal]"
      assert_select "input[name=?]", "emisor[registro_patronal]"
      assert_select "input[name=?]", "emisor[eslogan]"
    end
  end
end
