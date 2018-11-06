require 'rails_helper'

RSpec.describe "cajas/show", type: :view do
  before(:each) do
    @caja = assign(:caja, Caja.create!(
      :nombre => "Nombre",
      :numero => 304,
      :descripcion => "MyText",
      :disponible => true
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nombre/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Disponible/)
  end
end
