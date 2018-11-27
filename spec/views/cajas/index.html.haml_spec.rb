require 'rails_helper'

RSpec.describe "cajas/index", type: :view do
  before(:each) do
    assign(:cajas, Kaminari.paginate_array([
      Caja.create!(
        :nombre => "Nombre Uno",
        :numero => 301,
        :descripcion => "MyText",
        :disponible => true
      ),
      Caja.create!(
        :nombre => "Nombre Dos",
        :numero => 302,
        :descripcion => "MyText",
        :disponible => true
      )
    ]).page(1))
  end

  it "renders a list of cajas" do
    render
    assert_select "tr>td", :text => "Nombre Uno".to_s, :count => 1
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Disponible".to_s, :count => 2
  end
end
