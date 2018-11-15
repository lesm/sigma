require 'rails_helper'

RSpec.describe Comprobante, type: :model do
  it { should belong_to :caja }
  it { should belong_to :arqueo }
  it { should belong_to :cajero }
  it { should belong_to :contribuyente }
  it { should belong_to :emisor }

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
    let(:concepto) { create :concepto, :con_cuenta, :con_datos }
    let(:comprobante) do
      create :comprobante,
        :con_datos, forma_pago: "Efectivo",
        caja: cajero.caja, cajero: cajero,
        arqueo_id: nil, conceptos: [ concepto ]
    end
    describe "when comprobante belong to current cajero" do
      context "where comprobante.arqueo_id is nil" do

        describe ".monto_efectivo" do
          context "when comprobante forma_pago is not 'Efectivo'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Cheque nominativo")
              expect(Comprobante.monto_efectivo(cajero)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Efectivo'" do
            it "returns 400" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_efectivo(cajero)).to eq 400
            end
          end

          context "when comprobante forma_pago is 'Efectivo' and created_at is 2 days ago" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              comprobante.update_column(:created_at, 2.days.ago)
              expect(Comprobante.monto_efectivo(cajero)).to eq 0
            end
          end
        end

        describe ".monto_cheque" do
          context "when comprobante forma_pago is not 'Cheque'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_cheque(cajero)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Cheque'" do
            it "returns 400" do
              comprobante.update_column(:forma_pago, "Cheque nominativo")
              expect(Comprobante.monto_cheque(cajero)).to eq 400
            end
          end

          context "when comprobante forma_pago is 'Cheque nominativo' and created_at is 2 days ago" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Cheque nominativo")
              comprobante.update_column(:created_at, 2.days.ago)
              expect(Comprobante.monto_cheque(cajero)).to eq 0
            end
          end
        end

        describe ".monto_transferencia" do
          context "when comprobante forma_pago is not 'Transferencia electrónica de fondos'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Cheque nominativo")
              expect(Comprobante.monto_transferencia(cajero)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Transferencia electrónica de fondos'" do
            it "returns 400" do
              comprobante.update_column(:forma_pago, "Transferencia electrónica de fondos")
              expect(Comprobante.monto_transferencia(cajero)).to eq 400
            end
          end

          context "when comprobante forma_pago is 'Transferencia electrónica de fondos' and created_at is 2 days ago" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Transferencia electrónica de fondos")
              comprobante.update_column(:created_at, 2.days.ago)
              expect(Comprobante.monto_transferencia(cajero)).to eq 0
            end
          end
        end

        describe ".monto_tarjerta_credito" do
          context "when comprobante forma_pago is not 'Tarjeta de crédito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_tarjeta_credito(cajero)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Tarjeta de crédito'" do
            it "returns 400" do
              comprobante.update_column(:forma_pago, "Tarjeta de crédito")
              expect(Comprobante.monto_tarjeta_credito(cajero)).to eq 400
            end
          end

          context "when comprobante forma_pago is 'Tarjeta de crédito' and created_at is 2 days ago" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Tarjeta de crédito")
              comprobante.update_column(:created_at, 2.days.ago)
              expect(Comprobante.monto_tarjeta_credito(cajero)).to eq 0
            end
          end
        end

        describe ".monto_tarjerta_debito" do
          context "when comprobante forma_pago is not 'Tarjeta de débito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_tarjeta_debito(cajero)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Tarjeta de débito'" do
            it "returns 400" do
              comprobante.update_column(:forma_pago, "Tarjeta de débito")
              expect(Comprobante.monto_tarjeta_debito(cajero)).to eq 400
            end
          end

          context "when comprobante forma_pago is 'Tarjeta de débito' and created_at is 2 days ago" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Tarjeta de débito")
              comprobante.update_column(:created_at, 2.days.ago)
              expect(Comprobante.monto_tarjeta_debito(cajero)).to eq 0
            end
          end
        end

      end
    end

    describe "when comprobante does not belong to current cajero" do
      let(:cajero_dos) { create :cajero, :con_contribuyente, caja: caja }
      context "where comprobante.arqueo_id is nil" do

        describe ".monto_efectivo" do
          context "when comprobante forma_pago is not 'Efectivo'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Transferencia electrónica de fondos")
              expect(Comprobante.monto_efectivo(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Efectivo'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_efectivo(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_cheque" do
          context "when comprobante forma_pago is not 'Cheque'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_cheque(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Cheque'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Cheque nominativo")
              expect(Comprobante.monto_cheque(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_transferencia" do
          context "when comprobante forma_pago is not 'Transferencia electrónica de fondos'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_transferencia(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Transferencia electrónica de fondos'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Transferencia electrónica de fondos")
              expect(Comprobante.monto_transferencia(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_tarjerta_credito" do
          context "when comprobante forma_pago is not 'Tarjeta de crédito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_tarjeta_credito(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Tarjeta de crédito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Tarjeta de crédito")
              expect(Comprobante.monto_tarjeta_credito(cajero_dos)).to eq 0
            end
          end
        end

        describe ".monto_tarjerta_debito" do
          context "when comprobante forma_pago is not 'Tarjeta de débito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Efectivo")
              expect(Comprobante.monto_tarjeta_debito(cajero_dos)).to eq 0
            end
          end

          context "when comprobante forma_pago is 'Tarjeta de débito'" do
            it "returns 0" do
              comprobante.update_column(:forma_pago, "Tarjeta de débito")
              expect(Comprobante.monto_tarjeta_debito(cajero_dos)).to eq 0
            end
          end
        end

      end
    end
  end
end
