require "rails_helper"

RSpec.describe DatosMercado, type: :model do
  it { validate_presence_of :cantidad_folios_cinco }
  it { validate_presence_of :cantidad_folios_diez }
  it { validate_presence_of :responsable }
  it { validate_presence_of :fecha }

  describe "#cantidad_folios_cinco" do
    it "does not allow negative numbers" do
      subject.cantidad_folios_cinco = -10
      subject.valid?
      expect(subject.errors.keys).to include :cantidad_folios_cinco
    end

    it "allows number zero" do
      subject.cantidad_folios_cinco = 0
      subject.valid?
      expect(subject.errors.keys).to_not include :cantidad_folios_cinco
    end
  end

  describe "#cantidad_folios_diez" do
    it "does not allow negative numbers" do
      subject.cantidad_folios_diez = -10
      subject.valid?
      expect(subject.errors.keys).to include :cantidad_folios_diez
    end

    it "allows number zero" do
      subject.cantidad_folios_diez = 0
      subject.valid?
      expect(subject.errors.keys).to_not include :cantidad_folios_diez
    end
  end
end
