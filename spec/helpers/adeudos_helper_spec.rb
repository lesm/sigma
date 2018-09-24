require 'rails_helper'

RSpec.describe AdeudosHelper, type: :helper do
  describe "#liquidado" do
    it "returns Pendiente when liquidado is false" do
      @adeudo = FactoryBot.build :adeudo, liquidado: false
      expect(helper.liquidado(@adeudo)).to eq "Pendiente"
    end

    it "returns Pagado when liquidado is true" do
      @adeudo = FactoryBot.build :adeudo, liquidado: true
      expect(helper.liquidado(@adeudo)).to eq "Pagado"
    end
  end

  describe "#referer_url_arqueo" do
    context "request.referer is adeudo" do
      it "returns adeudos" do
        allow(helper.request).to receive(:referer).and_return ("http://localhost:3000/adeudos")
        expect(helper.referer_url_arqueo).to match /adeudos/
      end
    end

    context "request.referer is arqueo" do
      it "returns arqueo" do
        allow(helper.request).to receive(:referer).and_return ("http://localhost:3000/arqueos/1")
        expect(helper.referer_url_arqueo).to match /arqueos/
      end
    end
  end
end
