require 'rails_helper'

RSpec.describe "rake liberar_cajas:no_disponibles", type: :task do

  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  it "runs task no raise_error" do
    expect { task.execute }.not_to raise_error
  end

  describe "when Caja is not disponible" do
    let(:caja) { create :caja, disponible: false }
    let(:cajero) { create :cajero, :con_contribuyente, caja: caja }
    let(:cajero_dos) { create :cajero, :con_contribuyente, caja: caja }

    context "when comprobantes without Arqueo" do
      let!(:comprobantes_sin_arqueo) do
        create_list :comprobante, 5, :con_datos, cajero: cajero,
          caja: caja, arqueo_id: nil
      end
      let!(:comprobantes_sin_arqueo_cajero_dos) do
        create_list :comprobante, 5, :con_datos, cajero: cajero_dos,
          caja: caja, arqueo_id: nil
      end

      it "should create Arqueo and CierreCaja" do
        allow_any_instance_of(Caja).to receive(:update_historial_caja!)
          .and_return(HistorialCaja.new)

        expect{ task.execute }.to output(
          "Cierre automatico, se genero arqueo y cierre caja.\n"
        ).to_stdout

        abrir_caja
      end
    end

    context "when comprobantes with Arqueo" do
      let(:cierre_caja) do
        create :cierre_caja, :en_ceros, cajero: cajero,
          abierta: false
      end

      it "should not create Arqueo and CierreCaja" do
        cierre_caja
        allow_any_instance_of(Caja).to receive(:update_historial_caja!)
          .and_return(HistorialCaja.new)

        task.execute
        expect(Arqueo.count).to eq 2
        expect(CierreCaja.count).to eq 2

        abrir_caja
      end
    end

    context "when CierreCaja is abierta" do
      let(:cierre_cajas_abiertas) do
        create_list :cierre_caja, 5, :with_arqueo,
          cajero: cajero, abierta: true
      end

      before :each do
        cierre_cajas_abiertas
        cajero
        allow_any_instance_of(Caja).to receive(:update_historial_caja!)
          .and_return(HistorialCaja.new)
      end

      it "should closes CierreCaja" do
        task.execute
        expect{ task.execute }.to output(
          "Cierre automatico, se cerro el cierre caja.\n"
        ).to_stdout

        #TODO caja
        #abrir_caja
      end
    end

    context "when CierreCaja is cerrada" do
      let(:cierre_caja_cerrada) do
        create :cierre_caja, :with_arqueo,
          cajero: cajero, abierta: false
      end

      before :each do
        cierre_caja_cerrada
        allow_any_instance_of(Caja).to receive(:update_historial_caja!)
          .and_return(HistorialCaja.new)
        task.execute
      end

      it "should opens CierreCaja" do
        expect(CierreCaja.count).to eq 2

        abrir_caja
      end
    end

    context "when only Caja is not disponible" do
      before :each do
        cajero
        allow_any_instance_of(Caja).to receive(:update_historial_caja!)
          .and_return(HistorialCaja.new)
      end

      it "should be disponible" do
        expect{ task.execute }.to output(
          "Liberar caja, con arqueo y cierre caja en 0.\n"
        ).to_stdout

        abrir_caja
      end

      it "should create Arqueo and CierreCaja" do
        task.execute
        expect(Arqueo.count).to eq 1
        expect(CierreCaja.count).to eq 1

        abrir_caja
      end

      it "must be 0" do
        task.execute
        expect(Arqueo.first.monto_cajero).to eq 0
        expect(CierreCaja.first.monto_cajero).to eq 0

        abrir_caja
      end
    end
  end

  private

  def abrir_caja
    expect(caja.reload.disponible).to eq true
    expect(caja.reload.cajero_id).to be_nil
  end
end
