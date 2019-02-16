require "rails_helper"

RSpec.describe Recibo, type: :model do
  let(:comprobante) { build :recibo, :para_timbrar }

  describe "#after_save" do
    context "when timbrado_automatico is true" do
      it "a job was pushed on to the queue" do
        comprobante.timbrado_automatico = true
        expect { comprobante.save! }.to change(ComprobanteWorker.jobs, :size).by 1
      end
    end

    context "when timbrado_automatico is false" do
      it "a job was pushed on to the queue" do
        expect { comprobante.save! }.to change(ComprobanteWorker.jobs, :size).by 0
      end
    end
  end
end
