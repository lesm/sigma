require 'rails_helper'

RSpec.describe "contribuyentes/index", type: :view do
  before(:each) do
    assign(:contribuyentes, [
      Contribuyente.create!(
        :nombre_o_razon_social => "Pedro",
        :primer_apellido => "Pérez",
        :segundo_apellido => "Pérez",
        :persona_fisica => true,
        :email => "pedro@gmail.com",
        :rfc => "AAAA111111AAA"
      ),
      Contribuyente.create!(
        :nombre_o_razon_social => "Pedro",
        :primer_apellido => "Pérez",
        :segundo_apellido => "Pérez",
        :persona_fisica => true,
        :email => "pedro@gmail.com",
        :rfc => "AAAA111111AA1"
      )
    ])
  end

  it "renders a list of contribuyentes" do
    render
    assert_select "tr>td", :text => "Pedro Pérez Pérez".to_s, :count => 2
    assert_select "tr>td", :text => "Persona Física".to_s, :count => 2
    assert_select "tr>td", :text => "pedro@gmail.com".to_s, :count => 2
    assert_select "tr>td", :text => "AAAA111111AAA".to_s, :count => 1
    assert_select "tr>td", :text => "AAAA111111AA1".to_s, :count => 1
  end
end
