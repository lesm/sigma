require 'rails_helper'

RSpec.describe "adeudos/index", type: :view do
  let(:cajero) { FactoryBot.build :cajero }
  let(:arqueo) { FactoryBot.build :arqueo }
  let(:cierre_caja) { FactoryBot.create :cierre_caja, arqueos: [arqueo], cajero: cajero }

  let(:arqueo_dos) { FactoryBot.build :arqueo }
  let(:cierre_caja_dos) { FactoryBot.create :cierre_caja, arqueos: [arqueo_dos], cajero: cajero }

  before(:each) do
    cierre_caja
    cierre_caja_dos
    assign(:adeudos, Kaminari.paginate_array([
      Adeudo.create!(
        :anticipo => "0",
        :monto => "9.99",
        :liquidado => false,
        :cajero => cajero,
        :arqueo => arqueo
      ),
      Adeudo.create!(
        :anticipo => "0",
        :monto => "9.99",
        :liquidado => false,
        :cajero => cajero,
        :arqueo => arqueo_dos
      )
    ]).page(1))
  end

  it "renders a list of adeudos" do
    render
    assert_select "tr>td", :text => "$9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Pendiente".to_s, :count => 2
  end
end
