require "rails_helper"

RSpec.describe EmisorPresenter do
  let(:subject) do
    EmisorPresenter.new emisor
  end

  let(:emisor) do
    build :emisor, regimen_fiscal: "Personas morales con fines no lucrativos"
  end

  describe "#regimen_fiscal" do
    it "receives 'Personas morales con fines no lucrativos' and returns '603'" do
      expect(subject.regimen_fiscal).to eq "603"
    end
  end
end
