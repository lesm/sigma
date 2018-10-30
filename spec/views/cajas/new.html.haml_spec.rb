require 'rails_helper'

RSpec.describe "cajas/new", type: :view do
  before(:each) do
    assign(:caja, Caja.new(
      :nombre => "MyString",
      :descripcion => "MyText",
      :disponible => false
    ))
  end

  it "renders new caja form" do
    render

    assert_select "form[action=?][method=?]", cajas_path, "post" do
      assert_select "input[name=?]", "caja[nombre]"
      assert_select "textarea[name=?]", "caja[descripcion]"
    end
  end
end
