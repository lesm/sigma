require 'rails_helper'

RSpec.describe "cajeros/edit", type: :view do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  before(:each) do
    @cajero = assign(:cajero, Cajero.create!(
      nombre: "Carlos", username: "carlos", password: "1qaz2wsx",
      contribuyente_id: contribuyente.id
    ))
    assign(:contribuyente, Contribuyente.new)
  end

  it "renders the edit cajero form" do
    render
    assert_select "form[action=?][method=?]", cajero_path(@cajero), "post" do
      assert_select "input[name=?]", "cajero[nombre]"
      assert_select "input[name=?]", "cajero[username]"
      assert_select "input[name=?]", "cajero[password]"
    end
  end
end
