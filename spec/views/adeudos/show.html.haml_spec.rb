require 'rails_helper'

RSpec.describe "adeudos/show", type: :view do
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

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
  end
end
