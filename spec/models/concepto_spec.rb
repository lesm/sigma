require 'rails_helper'

RSpec.describe Concepto, type: :model do
  it { should belong_to :cuenta }
  it { should have_one(:datos_concepto).dependent(:destroy) }

  it { should validate_presence_of :valor_unitario }
  it { should validate_presence_of :clave }
  it { should validate_presence_of :clave_unidad }
  it { should validate_presence_of :importe }
  it { should validate_presence_of :cantidad }

  it { should accept_nested_attributes_for(:datos_concepto).allow_destroy(true) }
  it { should allow_values(5, 1).for(:cantidad) }

  describe "#importe" do
    let(:concepto) { build :concepto, cantidad: 2, valor_unitario: 100, importe: 300 }
    it "must be cantidad * valor_unitario" do
      concepto.valid?
      expect(concepto.errors.to_a.to_sentence).to match /debe ser 200/
    end
  end

  describe "#duplicar" do
    let(:recibo) { create :recibo, :de_predial }
    let(:concepto) { recibo.conceptos.first }

    it "returns a new instance that is not persisted" do
      expect(concepto.duplicar).to be_a_new Concepto
    end

    it "concepto does not change" do
      concepto and concepto.duplicar
      expect(concepto.changed?).to be false
    end

    it "copies its attributes" do
      new_concepto = concepto.duplicar
      expect(new_concepto.clave).to eq concepto.clave
      expect(new_concepto.clave_unidad).to eq concepto.clave_unidad
      expect(new_concepto.unidad).to eq concepto.unidad
      expect(new_concepto.cantidad).to eq concepto.cantidad
      expect(new_concepto.descripcion).to eq concepto.descripcion
      expect(new_concepto.valor_unitario).to eq concepto.valor_unitario
      expect(new_concepto.importe).to eq concepto.importe
      expect(new_concepto.cuenta_id).to eq concepto.cuenta_id
    end

    it "does not copy some attributes" do
      new_concepto = concepto.duplicar
      expect(new_concepto.id).to be_nil
      expect(new_concepto.created_at).to be_nil
      expect(new_concepto.updated_at).to be_nil
      expect(new_concepto.comprobante_id).to be_nil
    end

    context "include relationship" do
      it "the new instance must have datos_conceptos relationship" do
        expect(concepto.duplicar.datos_concepto).to be_a_new DatosConcepto
      end

      it "copies its attributes" do
        new_concepto = concepto.duplicar
        new_dc       = new_concepto.datos_concepto
        dc           = concepto.datos_concepto

        expect(new_dc.folio).to eq dc.folio
        expect(new_dc.clave_catastral).to eq dc.clave_catastral
        expect(new_dc.numero_cuenta).to eq dc.numero_cuenta
        expect(new_dc.ubicacion).to eq dc.ubicacion
        expect(new_dc.base_catastral).to eq dc.base_catastral
        expect(new_dc.impuesto_predial).to eq dc.impuesto_predial
        expect(new_dc.observaciones).to eq dc.observaciones
        expect(new_dc.fecha).to eq dc.fecha
        expect(new_dc.serie).to eq dc.serie
        expect(new_dc.placa).to eq dc.placa
        expect(new_dc.estimacion).to eq dc.estimacion
        expect(new_dc.nombre_obra).to eq dc.nombre_obra
        expect(new_dc.localidad).to eq dc.localidad
        expect(new_dc.nombre_contratista).to eq dc.nombre_contratista
        expect(new_dc.fecha_refrendo).to eq dc.fecha_refrendo
        expect(new_dc.type).to eq dc.type
        expect(new_dc.cantidad_folios_cinco).to eq dc.cantidad_folios_cinco
        expect(new_dc.cantidad_folios_diez).to eq dc.cantidad_folios_diez
        expect(new_dc.responsable).to eq dc.responsable
        expect(new_dc.numero_contrato).to eq dc.numero_contrato
        expect(new_dc.numero_medidor).to eq dc.numero_medidor
        expect(new_dc.lectura_actual).to eq dc.lectura_actual
        expect(new_dc.lectura_anterior).to eq dc.lectura_anterior
        expect(new_dc.consumo).to eq dc.consumo
        expect(new_dc.ruta).to eq dc.ruta
        expect(new_dc.lecturista).to eq dc.lecturista
        expect(new_dc.fecha_corte).to eq dc.fecha_corte
        expect(new_dc.mes_pago).to eq dc.mes_pago
        expect(new_dc.years).to eq dc.years
      end

      it "does not copy some attributes" do
        new_concepto = concepto.duplicar
        new_dc       = new_concepto.datos_concepto
        dc           = concepto.datos_concepto

        expect(new_dc.id).to be_nil
        expect(new_dc.concepto_id).to be_nil
        expect(new_dc.created_at).to be_nil
        expect(new_dc.updated_at).to be_nil
      end
    end
  end
end
