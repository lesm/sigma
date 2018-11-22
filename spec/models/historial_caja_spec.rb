require "rails_helper"

RSpec.describe HistorialCaja, type: :model do
  it { should belong_to :caja }
  it { should belong_to :cajero }

  it { should validate_presence_of :caja_id }

  describe ".last_historial_caja" do
    let(:caja) { create :caja }
    let(:cajero) do
      create :cajero, :con_contribuyente, caja: caja
    end
    let(:historial_uno) do
      create :historial_caja, cajero: cajero,
        caja: caja, created_at: 2.days.ago, fecha_cierre: 2.days.ago
    end
    let(:historial_dos) do
      create :historial_caja, cajero: cajero,
        caja: caja, created_at: 1.days.ago, fecha_cierre: nil
    end
    let(:historial_tres) do
      create :historial_caja, cajero: cajero,
        caja: caja, created_at: Date.current, fecha_cierre: Date.current
    end

    it "last historial caja of cajero and caja" do
      [historial_uno, historial_dos, historial_tres]
      expect(HistorialCaja.last_historial_caja(caja)).to eq historial_dos
    end
  end
end
