require 'rails_helper'

RSpec.describe "cajas/edit", type: :view do
  before(:each) do
    @caja = assign(:caja, Caja.create!(
      :nombre => "MyString",
      :descripcion => "MyText",
      :disponible => true
    ))
  end

  it "renders the edit caja form" do
    render

    assert_select "form[action=?][method=?]", caja_path(@caja), "post" do
      assert_select "input[name=?]", "caja[nombre]"
      assert_select "textarea[name=?]", "caja[descripcion]"
    end
  end
end
