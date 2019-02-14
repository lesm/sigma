require 'rails_helper'

RSpec.describe Comprobante, type: :model do
  it { should belong_to :caja }
  it { should belong_to :arqueo }
  it { should belong_to :cajero }
  it { should belong_to :contribuyente }
  it { should belong_to :emisor }

  it { should have_one :timbre }
  it { should have_many(:conceptos).dependent(:destroy) }
  it { should accept_nested_attributes_for :conceptos }

  it { should validate_presence_of :folio }
  it { should validate_presence_of :moneda }
  it { should validate_presence_of :tipo_comprobante }
  it { should validate_presence_of :lugar_expedicion }
  it { should validate_presence_of :metodo_pago }
  it { should validate_presence_of :forma_pago }
  it { should validate_presence_of :subtotal }
  it { should validate_presence_of :descuento }
  it { should validate_presence_of :total }
  it { should validate_numericality_of(:total).is_greater_than(0) }
  it { should validate_numericality_of(:subtotal).is_greater_than(0) }

  let(:comprobante) { create :recibo, :para_timbrar }

  describe "AASM process" do
    describe "sin_timbre initial state" do
      it "aasm_state == 'sin_timbre'" do
        expect(comprobante).to be_sin_timbre
      end
    end

    describe "sin_timbre -> procesando" do
      it "aasm_state == 'procesando'", :vcr do
        comprobante.continuar_timbrando!
        expect(comprobante).to be_procesando
      end
    end

    context "procesando state" do
      describe "procesando -> con_respuesta_valida" do
        it "aasm_state == 'con_respuesta_valida'", :vcr do
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          expect(comprobante).to be_con_respuesta_valida
        end
      end

      describe "procesando -> con_respuesta_invalida" do
        let(:emisor) { create :emisor }
        let(:comprobante) { create :recibo, :para_timbrar, emisor: emisor }

        it "aasm_state == 'con_respuesta_invalida'", :vcr do
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          expect(comprobante).to be_con_respuesta_invalida
        end
      end
    end

    context "con_respuesta_valida state" do
      describe "con_respuesta_valida -> con_timbre" do
        before :each do
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
        end

        it "aasm_state == 'con_timbre'", :vcr do
          expect(comprobante).to be_con_timbre
        end

        it "comprobante must have one timbre relationship", :vcr do
          expect(comprobante.timbre).to_not be_nil
        end
      end
    end

    context "con_timbre state" do
      describe "con_timbre -> con_xml" do
        before :each do
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
        end

        it "aasm_state == 'con_xml'", :vcr do
          expect(comprobante).to be_con_xml
        end

        it "comprobante xml attribute must exist", :vcr do
          expect(comprobante.xml).to_not be_nil
        end
      end
    end

    context "con_xml state" do
      before :each do
        comprobante.continuar_timbrando!
        comprobante.continuar_timbrando!
        comprobante.continuar_timbrando!
        comprobante.continuar_timbrando!
        comprobante.continuar_timbrando!
      end

      describe "con_xml -> con_cbb" do
        it "aasm_state == 'con_cbb'", :vcr do
          expect(comprobante).to be_con_cbb
        end

        it "comprobante cbb attribute must exist", :vcr do
          expect(comprobante.cbb).to_not be_nil
        end
      end
    end

    context "con_cbb state" do
      describe "con_cbb -> con_pdf" do
        before :each do
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
          comprobante.continuar_timbrando!
        end

        it "aasm_state == 'con_pdf'", :vcr do
          expect(comprobante).to be_con_pdf
        end

        it "comprobante pdf attribute must exist", :vcr do
          expect(comprobante.pdf).to_not be_nil
        end
      end
    end

    xcontext "con_pdf state" do
      describe "con_pdf -> cancelado if cancelacion_valida?" do
      end
    end
  end

  describe "#uso_cfdi" do
    let(:recibo) do
      build :recibo, :para_timbrar, uso_cfdi: nil
    end

    it "must be valid" do
      expect(recibo).to be_valid
    end

    it "must be presence when timbrado_automatico is true" do
      recibo.timbrado_automatico = true
      expect(recibo).to_not be_valid
      expect(recibo.errors[:uso_cfdi].join).to eq "no puede estar en blanco"
    end
  end

  describe "#valida_subtotal" do
    let(:concepto) { build :concepto, cantidad: 2, valor_unitario: 200, importe: 400 }
    let(:comprobante) { build :comprobante, conceptos: [concepto], subtotal: 500, total: 400 }
    context "#subtotal" do
      it "must be equals to total" do
        expect(comprobante).to be_invalid
        expect(comprobante.errors.to_a.to_sentence).to match /debe ser igual a total/
      end
    end
  end

  describe "#valida_total" do
    let(:concepto) { build :concepto, cantidad: 2, valor_unitario: 200, importe: 400 }
    let(:comprobante) { build :comprobante, conceptos: [concepto], subtotal: 400, total: 500 }
    context "#total" do
      it "must be equals to sum of conceptos' importe" do
        expect(comprobante).to be_invalid
        expect(comprobante.errors.to_a.to_sentence).to match /debe ser igual a la suma del importe de los conceptos/
      end
    end
  end

  describe "monto forma_pagos" do
    let(:caja) { create :caja }
    let(:cajero) { create :cajero, :con_contribuyente, caja: caja }
    let(:concepto) { build :concepto, :con_cuenta, :con_datos }
    let(:comprobante) do
      create :comprobante,
        :con_datos, forma_pago: "01 - Efectivo",
        caja: cajero.caja, cajero: cajero,
        arqueo_id: nil, conceptos: [ concepto ]
    end

    let(:comprobante_tarjeta_debito) do
      create :comprobante,
        :con_datos, forma_pago: "28 - Tarjeta de débito",
        caja: cajero.caja, cajero: cajero,
        arqueo_id: nil, conceptos: [ concepto ]
    end

    let(:comprobante_cheque_nominativo) do
      create :comprobante,
        :con_datos, forma_pago: "02 - Cheque nominativo",
        caja: cajero.caja, cajero: cajero,
        arqueo_id: nil, conceptos: [ concepto ]
    end

    describe "when comprobante belong to current cajero" do
      context "where comprobante.arqueo_id is nil" do
        context "when comprobantes are the current day" do
          describe ".monto_total" do
            it "is the sum of comprobante total" do
              [comprobante, comprobante_tarjeta_debito, comprobante_cheque_nominativo]
              expect(Comprobante.monto_total(cajero)).to eq 1200
            end
          end

          describe ".monto_no_efectivo" do
            context "when comprobante forma_pago is 'efectivo' and total is 400" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "01 - Efectivo")
                expect(Comprobante.monto_no_efectivo(cajero)).to eq 0
              end
            end

            context "when comprobante forma_pago is 'Cheque nominativo' and total is 400" do
              it "returns 400" do
                comprobante.update_column(:forma_pago, "02 - Cheque nominativo")
                expect(Comprobante.monto_no_efectivo(cajero)).to eq 400
              end
            end

            context "when there are three comprobantes" do
              context "most be the sum of payment method different of '01 - Efectivo'" do
                it "returns 800" do
                  comprobante
                  comprobante_tarjeta_debito
                  comprobante_cheque_nominativo
                  expect(Comprobante.monto_no_efectivo(cajero)).to eq 800
                end
              end
            end
          end

          describe ".monto_efectivo" do
            context "when comprobante forma_pago is not '01 - Efectivo'" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "02 - Cheque nominativo")
                expect(Comprobante.monto_efectivo(cajero)).to eq 0
              end
            end

            context "when comprobante forma_pago is '01 - Efectivo'" do
              it "returns 400" do
                comprobante.update_column(:forma_pago, "01 - Efectivo")
                expect(Comprobante.monto_efectivo(cajero)).to eq 400
              end
            end

            context "when comprobante forma_pago is '01 - Efectivo' and created_at is 2 days ago" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "01 - Efectivo")
                comprobante.update_column(:created_at, 2.days.ago)
                expect(Comprobante.monto_efectivo(cajero)).to eq 0
              end
            end
          end

          describe ".monto_cheque" do
            context "when comprobante forma_pago is not '02 - Cheque'" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "01 - Efectivo")
                expect(Comprobante.monto_cheque(cajero)).to eq 0
              end
            end

            context "when comprobante forma_pago is '02 - Cheque'" do
              it "returns 400" do
                comprobante.update_column(:forma_pago, "02 - Cheque nominativo")
                expect(Comprobante.monto_cheque(cajero)).to eq 400
              end
            end

            context "when comprobante forma_pago is '02 - Cheque nominativo' and created_at is 2 days ago" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "02 - Cheque nominativo")
                comprobante.update_column(:created_at, 2.days.ago)
                expect(Comprobante.monto_cheque(cajero)).to eq 0
              end
            end
          end

          describe ".monto_transferencia" do
            context "when comprobante forma_pago is not '03 - Transferencia electrónica de fondos'" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "02 - Cheque nominativo")
                expect(Comprobante.monto_transferencia(cajero)).to eq 0
              end
            end

            context "when comprobante forma_pago is '03 - Transferencia electrónica de fondos'" do
              it "returns 400" do
                comprobante.update_column(:forma_pago, "03 - Transferencia electrónica de fondos")
                expect(Comprobante.monto_transferencia(cajero)).to eq 400
              end
            end

            context "when comprobante forma_pago is '03 - Transferencia electrónica de fondos' and created_at is 2 days ago" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "03 - Transferencia electrónica de fondos")
                comprobante.update_column(:created_at, 2.days.ago)
                expect(Comprobante.monto_transferencia(cajero)).to eq 0
              end
            end
          end

          describe ".monto_tarjerta_credito" do
            context "when comprobante forma_pago is not 'Tarjeta de crédito'" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "01 - Efectivo")
                expect(Comprobante.monto_tarjeta_credito(cajero)).to eq 0
              end
            end

            context "when comprobante forma_pago is '04 - Tarjeta de crédito'" do
              it "returns 400" do
                comprobante.update_column(:forma_pago, "04 - Tarjeta de crédito")
                expect(Comprobante.monto_tarjeta_credito(cajero)).to eq 400
              end
            end

            context "when comprobante forma_pago is '04 - Tarjeta de crédito' and created_at is 2 days ago" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "04 - Tarjeta de crédito")
                comprobante.update_column(:created_at, 2.days.ago)
                expect(Comprobante.monto_tarjeta_credito(cajero)).to eq 0
              end
            end
          end

          describe ".monto_tarjerta_debito" do
            context "when comprobante forma_pago is not '28 - Tarjeta de débito'" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "01 - Efectivo")
                expect(Comprobante.monto_tarjeta_debito(cajero)).to eq 0
              end
            end

            context "when comprobante forma_pago is '28 - Tarjeta de débito'" do
              it "returns 400" do
                comprobante.update_column(:forma_pago, "28 - Tarjeta de débito")
                expect(Comprobante.monto_tarjeta_debito(cajero)).to eq 400
              end
            end

            context "when comprobante forma_pago is '04 - Tarjeta de débito' and created_at is 2 days ago" do
              it "returns 0" do
                comprobante.update_column(:forma_pago, "04 - Tarjeta de débito")
                comprobante.update_column(:created_at, 2.days.ago)
                expect(Comprobante.monto_tarjeta_debito(cajero)).to eq 0
              end
            end
          end

        end
      end
    end

    describe "when comprobante does not belong to current cajero" do
      let(:cajero_dos) { create :cajero, :con_contribuyente, caja: caja }
      context "where comprobante.arqueo_id is nil" do

        describe ".monto_efectivo" do
          context "when comprobante forma_pago is not '01 - Efectivo'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "03 - Transferencia electrónica de fondos")
              expect(Comprobante.monto_efectivo(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is '01 - Efectivo'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "01 - Efectivo")
              expect(Comprobante.monto_efectivo(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_cheque" do
          context "when comprobante forma_pago is not '02 - Cheque'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "01 - Efectivo")
              expect(Comprobante.monto_cheque(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is '02 - Cheque'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "02 - Cheque nominativo")
              expect(Comprobante.monto_cheque(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_transferencia" do
          context "when comprobante forma_pago is not '03 - Transferencia electrónica de fondos'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "01 - Efectivo")
              expect(Comprobante.monto_transferencia(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is '03 - Transferencia electrónica de fondos'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "03 - Transferencia electrónica de fondos")
              expect(Comprobante.monto_transferencia(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_tarjerta_credito" do
          context "when comprobante forma_pago is not '04 - Tarjeta de crédito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "01 - Efectivo")
              expect(Comprobante.monto_tarjeta_credito(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is '04 - Tarjeta de crédito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "04 - Tarjeta de crédito")
              expect(Comprobante.monto_tarjeta_credito(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_tarjerta_debito" do
          context "when comprobante forma_pago is not '28 - Tarjeta de débito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "01 - Efectivo")
              expect(Comprobante.monto_tarjeta_debito(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is '28 - Tarjeta de débito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "28 - Tarjeta de débito")
              expect(Comprobante.monto_tarjeta_debito(cajero_dos)).to eq 0
            end
          end
        end
      end
    end
  end
end
