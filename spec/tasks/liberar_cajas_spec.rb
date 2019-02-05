require 'rails_helper'

RSpec.describe "rake liberar_cajas:ocupadas", type: :task do

  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  it "runs task no raise_error" do
    expect { task.execute }.not_to raise_error
  end

  describe "When Caja is not disponible" do
    let(:caja) { create :caja, disponible: false }
    let(:caja_dos) { create :caja, disponible: false }
    let(:cajero) { create :cajero, :con_contribuyente, caja: caja }
    let(:cajero_dos) do
      create :cajero, :con_contribuyente, caja: caja_dos
    end
    let(:historial_caja) do
      create :historial_caja, caja: caja, cajero: cajero
    end
    let(:historial_caja_dos) do
      create :historial_caja, caja: caja_dos, cajero: cajero_dos
    end

    before :each do
      [caja, caja_dos]
      [cajero, cajero_dos]
      [historial_caja, historial_caja_dos]
    end

    context "when Cajero needs a CierreCaja with an Arqueo" do
      let(:comprobantes_sin_arqueo) do
        create_list :recibo, 5, :para_nuevo_arqueo,
          cajero: cajero, caja: caja, arqueo_id: nil
      end

      let(:cierre_caja_abierta) do
        create :cierre_caja, :en_ceros_con_arqueo,
          cajero: cajero_dos, abierta: true
      end

      before :each do
        [comprobantes_sin_arqueo, cierre_caja_abierta]
      end

      it "An Arqueo must be created with all comprobantes" do
        expect {
          task.execute
        }.to change { cajero.arqueos.count }.by(1)
        expect(cajero.arqueos.first.recibos.count).to eq 5
      end

      it "A CierreCaja must be created with an arqueo" do
        expect {
          task.execute
        }.to change { cajero.cierre_cajas.count }.by(1)
        expect(cajero.cierre_cajas.first.arqueos.count).to eq 1
      end

      it "A CierreCaja must be automatico 'true'" do
        task.execute
        expect(cajero.cierre_cajas.first.automatico).to eq true
      end

      it "HistorialCaja fecha_cierre must be updated" do
        task.execute
        expect(caja.historial_cajas.last.fecha_cierre).to_not be_nil
      end

      it "Caja must be open" do
        task.execute
        caja_debe_estar_abierta
      end

      it "cajero_dos CierreCaja must be closed" do
        task.execute
        expect(cajero_dos.cierre_cajas.first).to_not be_abierta
        expect(cajero_dos.cierre_cajas.count).to eq 1
        expect(cajero_dos.arqueos.count).to eq 1
      end
    end

    context "when Cajero just needs to close CierreCaja" do
      let(:cierre_caja_abierta) do
        create :cierre_caja, :en_ceros_con_arqueo,
          cajero: cajero, abierta: true
      end

      before :each do
        cierre_caja_abierta
      end

      it "CierreCaja must be closed" do
        task.execute
        expect(caja.cajero.cierre_cajas.first).to_not be_abierta
      end

      it "Caja must be open" do
        task.execute
        caja_debe_estar_abierta
      end

      it "cajero CierreCaja must be has one and must be closed" do
        task.execute
        expect(cajero.cierre_cajas.first).to_not be_abierta
        expect(cajero.cierre_cajas.count).to eq 1
        expect(cajero.arqueos.count).to eq 1
      end

      it "A CierreCaja must be automatico 'true'" do
        task.execute
        expect(cajero.cierre_cajas.first.automatico).to eq true
      end
    end

    context "when Cajero needs to create Arqueos and CierreCaja in 0" do
      it "Arqueo must be 0" do
        task.execute
        expect(caja.cajero.arqueos.first.monto_sistema).to eq 0
        expect(caja.cajero.arqueos.first.monto_cajero).to eq 0
      end

      it "CierreCaja must be 0" do
        task.execute
        expect(caja.cajero.cierre_cajas.first.monto_sistema).to eq 0
        expect(caja.cajero.cierre_cajas.first.monto_cajero).to eq 0
      end

      it "CierreCaja must be automatico 'true'" do
        task.execute
        expect(cajero.cierre_cajas.first.automatico).to eq true
      end

      it "Caja must be open" do
        task.execute
        caja_debe_estar_abierta
      end
    end
  end

  private

  def caja_debe_estar_abierta
    expect(caja.reload.disponible).to eq true
    expect(caja.reload.cajero_id).to be_nil
  end
end
