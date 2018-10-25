require 'rails_helper'

RSpec.describe Contribuyente, type: :model do
  it { should validate_presence_of(:nombre_o_razon_social) }
  it { should validate_presence_of(:primer_apellido) }
  it { should accept_nested_attributes_for(:direccion).allow_destroy(true) }
  it { should have_one(:cajero) }
  it { should have_one(:direccion).dependent(:destroy) }
  it { should accept_nested_attributes_for(:direccion).allow_destroy(true) }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }

  describe "#nombre_completo" do
    subject do
      build :contribuyente,
        nombre_o_razon_social: 'Pedro',
        primer_apellido: 'Pérez',
        segundo_apellido: 'Pérez'
    end
    it "une nombre, primer apellido, segundo apellido" do
      expect(subject.nombre_completo).to eq 'Pedro Pérez Pérez'
    end
  end

  describe "Persona fisica" do
    context "primer apellido" do
      subject { build :contribuyente, persona_fisica: true }
      it "debe estar presente" do
        subject.primer_apellido = nil
        expect(subject).to_not be_valid
      end
    end # context primer apellido

    context "rfc" do
      context "debe ser 13 dígitos" do
        subject { build :contribuyente, rfc: 'AAAA111111AA' }
        it "debe ser 13 digitos" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /debe ser de 13 caracteres/
        end
      end # context debe ser 13 dígitos

      context "puede no estar presente" do
        subject { build :contribuyente, rfc: nil }
        it "debe ser válido" do
          expect(subject).to be_valid
        end
      end

      context "formato no valido" do
        subject { build :contribuyente, rfc: '1111AAAAAA111' }
        it "no debe ser válido" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /Rfc no es un RFC válido/
        end
      end
    end
  end # describe "Persona fisica"

  describe "Persona moral" do
    context "primer_apellido" do
      subject { build :contribuyente, persona_fisica: false, rfc: 'AAA111111AAA' }
      it "no es necesario" do
        subject.primer_apellido = nil
        expect(subject).to be_valid
      end
    end # context primer_apellido

    context "rfc" do
      context "debe ser 12 dígitos" do
        subject { build :contribuyente, persona_fisica: false, rfc: 'AAAA111111AAA' }
        it "debe ser 12 digitos" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /debe ser de 12 caracteres/
        end
      end # context debe ser 12 dígitos

      context "puede no estar presente" do
        subject { build :contribuyente, persona_fisica: false, rfc: nil }
        it "debe ser válido" do
          expect(subject).to be_valid
        end
      end

      context "formato no valido" do
        subject { build :contribuyente, persona_fisica: false, rfc: '1111AAAAAA11' }
        it "no debe ser válido" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /Rfc no es un RFC válido/
        end
      end
    end
  end # describe "Persona moral"

  describe "#rfc" do
    let(:contribuyente) { create :contribuyente, persona_fisica: true, rfc: "AAAA111111AAA" }
    let(:contribuyente_dos) { build :contribuyente, persona_fisica: true, rfc: "AAAA111111AAA" }
    let(:contribuyente_tres) { create :contribuyente, persona_fisica: true, rfc: nil }
    let(:contribuyente_cuatro) { create :contribuyente, persona_fisica: true, rfc: "XAXX010101000" }
    let(:contribuyente_cinco) { create :contribuyente, persona_fisica: true, rfc: "XAXX010101000" }

    it "must be uniq" do
      expect(contribuyente).to be_valid
      expect(contribuyente_dos).to_not be_valid
    end # context must bu uniq

    it "can be blank" do
      expect(contribuyente_tres).to be_valid
    end

    context "rfc generico" do
      it "is not necessary to be uniq" do
        expect(contribuyente_cuatro).to be_valid
        expect(contribuyente_cinco).to be_valid
      end # context must bu uniq
    end
  end # describe "#rfc"
end
