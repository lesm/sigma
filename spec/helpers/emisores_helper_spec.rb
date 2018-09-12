require 'rails_helper'

RSpec.describe EmisoresHelper, type: :helper do
  describe "#no_exite_emisor?" do
    it "returns true when Emisor.count == 0" do
      expect(helper.no_exite_emisor?).to be_truthy
    end

    it "returns false when Emisor.count >= 1" do
      FactoryBot.create :emisor
      expect(helper.no_exite_emisor?).to be_falsey
    end
  end
end
