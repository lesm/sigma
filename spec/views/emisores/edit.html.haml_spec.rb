require 'rails_helper'

RSpec.describe "emisores/edit", type: :view do
  before(:each) do
    @emisor = assign(:emisor, Emisor.create!(
      :nombre => "MyString",
      :rfc => "AAA111111AAA",
      :logo => "MyString",
      :regimen_fiscal => "MyString",
      :registro_patronal => "MyString",
      :lugar_expedicion => "MyString"
    ))
  end

  it "renders the edit emisor form" do
    render

    assert_select "form[action=?][method=?]", emisor_path(@emisor), "post" do

      assert_select "input[name=?]", "emisor[nombre]"

      assert_select "input[name=?]", "emisor[rfc]"

      assert_select "input[name=?]", "emisor[logo]"

      assert_select "input[name=?]", "emisor[regimen_fiscal]"

      assert_select "input[name=?]", "emisor[registro_patronal]"

      assert_select "input[name=?]", "emisor[lugar_expedicion]"
    end
  end
end
