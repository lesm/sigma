require 'rails_helper'

RSpec.describe "arqueos/new", type: :view do
  before(:each) do
    sign_in_cajero
    assign(:arqueo, Arqueo.new(
      :monto_sistema => "9.99",
      :monto_cajero => "9.99",
      :observacion => "MyText",
    ))
  end

  it "renders new arqueo form" do
    render

    assert_select "form[action=?][method=?]", arqueos_path, "post" do
      assert_select "input[name=?]", "arqueo[monto_cajero]"
      assert_select "textarea[name=?]", "arqueo[observacion]"
    end
  end
end
