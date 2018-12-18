require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#previous_url" do
    before :each do
      allow(helper.request).to receive(:referrer).and_return(previous_url)
    end

    context "previous url is different of recibo_step(:set_conepto)" do
      let(:previous_url) { root_path }
      it "returns :back symbol" do
        expect(helper.previous_url).to eq :back
      end
    end

    context "previous url is recibo_step(:set_conepto)" do
      let(:previous_url) { recibo_step_path(:set_cuenta) }

      it "returns recibo_step_path(:set_cuenta, @cuenta_params)" do
        @cuenta_params = {
          contribuyente_id: 1,
          cuenta_ids: [1,2,3]
        }
        expect(helper.previous_url).to eq recibo_step_path(:set_cuenta, @cuenta_params)
      end
    end
  end
end
