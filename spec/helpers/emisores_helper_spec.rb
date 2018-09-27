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

  describe "#nombre_submit" do
    context "action_name is new" do
      it "returns 'Crear Municipio'" do
        allow(helper).to receive(:action_name).and_return("new")
        expect(helper.texto_submit).to eq "Crear Municipio"
      end
    end

    context "action_name is edit" do
      it "returns 'Actualizar Municipio'" do
        allow(helper).to receive(:action_name).and_return("edit")
        expect(helper.texto_submit).to eq "Actualizar Municipio"
      end
    end
  end
end
