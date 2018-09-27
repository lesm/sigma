require 'rails_helper'

RSpec.describe "cajeros/new", type: :view do
  before(:each) do
    assign(:cajero, Cajero.new(
      nombre: "Cajero",
      username: "cajerito",
      password: "1qaz2wsx",
      activo: true,
      rol: 1,
    ))
  end

  it "renders new cajero form" do
    render

    assert_select "form[action=?][method=?]", cajeros_path, "post" do
      assert_select "input[name=?]", "cajero[nombre]"
      assert_select "input[name=?]", "cajero[username]"
      assert_select "input[name=?]", "cajero[password]"
      assert_select "input[name=?]", "cajero[activo]"
    end
  end
end
