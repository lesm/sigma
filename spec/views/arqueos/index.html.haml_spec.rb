require 'rails_helper'

RSpec.describe "arqueos/index", type: :view do
  let(:usuario) { FactoryBot.create :usuario }
  let(:cierre_caja) { FactoryBot.create :cierre_caja, usuario: usuario }
  before(:each) do
    assign(:arqueos, [
      Arqueo.create!(
        :monto => "9.99",
        :observacion => "MyText",
        :cierre_caja => cierre_caja
      ),
      Arqueo.create!(
        :monto => "9.99",
        :observacion => "MyText",
        :cierre_caja => cierre_caja
      )
    ])
  end

  it "renders a list of arqueos" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
