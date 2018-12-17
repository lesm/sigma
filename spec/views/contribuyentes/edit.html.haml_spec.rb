require 'rails_helper'

RSpec.describe "contribuyentes/edit", type: :view do
  let(:rifas) { create :cuenta, :rifas }

  before(:each) do
    @contribuyente = assign(:contribuyente, Contribuyente.create!(
      :nombre_o_razon_social => "Pedro",
      :primer_apellido => "Pérez",
      :segundo_apellido => "Pérez",
      :persona_fisica => true,
      :email => "pedro@gmail.com",
      :rfc => "AAAA111111AAA",
      :concepto_ids => [rifas.id]
    ))
  end

  it "renders the edit contribuyente form" do
    render

    assert_select "form[action=?][method=?]", contribuyente_path(@contribuyente), "post" do
      assert_select "input[name=?]", "contribuyente[nombre_o_razon_social]"
      assert_select "input[name=?]", "contribuyente[primer_apellido]"
      assert_select "input[name=?]", "contribuyente[segundo_apellido]"
      assert_select "input[name=?]", "contribuyente[persona_fisica]"
      assert_select "input[name=?]", "contribuyente[email]"
      assert_select "input[name=?]", "contribuyente[rfc]"
    end
  end
end
