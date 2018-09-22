require 'rails_helper'

RSpec.describe "adeudos/edit", type: :view do
  let(:cajero) { FactoryBot.build :cajero }
  let(:arqueo) { FactoryBot.build :arqueo }
  let(:cierre_caja) { FactoryBot.create :cierre_caja, arqueos: [arqueo], cajero: cajero }

  before(:each) do
    cierre_caja
    @adeudo = assign(:adeudo, Adeudo.create!(
      :anticipo => "9.99",
      :monto => "9.99",
      :liquidado => false,
      :cajero => cajero,
      :arqueo => arqueo
    ))
  end

  it "renders the edit adeudo form" do
    render

    assert_select "form[action=?][method=?]", adeudo_path(@adeudo), "post" do
      assert_select "input[name=?]", "adeudo[anticipo]"
      assert_select "input[name=?]", "adeudo[monto]"
      assert_select "input[name=?]", "adeudo[liquidado]"
      assert_select "select[name=?]", "adeudo[cajero_id]"
      assert_select "select[name=?]", "adeudo[arqueo_id]"
    end
  end
end
