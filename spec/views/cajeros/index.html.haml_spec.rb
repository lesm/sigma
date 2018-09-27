require 'rails_helper'

RSpec.describe "cajeros/index", type: :view do
  before(:each) do
    assign(:cajeros, [
      Cajero.create!(
        nombre: "Cajero",
        username: "cajerito",
        password: "1qaz2wsx",
        activo: true,
        rol: 1,
      ),
      Cajero.create!(
        nombre: "Cajero",
        username: "cajerote",
        password: "1qaz2wsx",
        activo: true,
        rol: 1,
      ),
    ])
  end

  it "renders a list of cajeros" do
    render
    assert_select "tr>td", :text => "Cajero".to_s, :count => 2
    assert_select "tr>td", :text => "cajerito".to_s, :count => 1
    assert_select "tr>td", :text => "cajerote".to_s, :count => 1
  end
end
