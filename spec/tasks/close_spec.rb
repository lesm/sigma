require 'rails_helper'

RSpec.describe "rake close:cajas", type: :task do

  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  it "runs task no raise_error" do
    expect { task.execute }.not_to raise_error
  end

  describe "when Caja is not disponible" do
    let(:caja) { create :caja, disponible: false }
    let(:cajero) { create :cajero, :con_contribuyente, caja: caja }

    context "exists comprobantes without arqueo" do
      let(:comprobantes_sin_arqueo) do
        create_list :comprobante, 5, :con_datos, cajero: cajero,
          caja: caja, arqueo_id: nil
      end

      it "should create Arqueo and CierreCaja" do
        comprobantes_sin_arqueo

        expect{ task.execute }.to output(
          "Cierre automatico, se genero arqueo y cierre caja.\n"
        ).to_stdout
      end
    end

    context "CierreCaja is abierta" do
      let(:cierre_cajas_abiertas) do
        create_list :cierre_caja, 5, :with_arqueo,
          cajero: cajero, abierta: true
      end

      it "should closes CierreCaja" do
        cierre_cajas_abiertas

        expect{ task.execute }.to output(
          "Cierre automatico, se cerro el cierre caja.\n"
        ).to_stdout
      end
    end
  end
end
