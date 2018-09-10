require 'rails_helper'

RSpec.describe Contribuyente, type: :model do
  it { should validate_presence_of(:nombre_o_razon_social) }
  it { should validate_presence_of(:primer_apellido) }
  it { should accept_nested_attributes_for(:direccion) }
  it { should have_one(:direccion) }

  describe "#nombre_completo" do
    subject do
      FactoryBot.build :contribuyente,
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
      subject { FactoryBot.build :contribuyente, persona_fisica: true }
      it "debe estar presente" do
        subject.primer_apellido = nil
        expect(subject).to_not be_valid
      end
    end # context primer apellido

    context "rfc" do
      context "debe ser 13 dígitos" do
        subject { FactoryBot.build :contribuyente, rfc: 'AAAA111111AA' }
        it "debe ser 13 digitos" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /debe ser de 13 caracteres/
        end
      end # context debe ser 13 dígitos

      context "puede no estar presente" do
        subject { FactoryBot.build :contribuyente, rfc: nil }
        it "debe ser válido" do
          expect(subject).to be_valid
        end
      end

      context "formato no valido" do
        subject { FactoryBot.build :contribuyente, rfc: '1111AAAAAA111' }
        it "no debe ser válido" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /Rfc no es un RFC válido/
        end
      end
    end
  end # describe "Persona fisica"

  describe "Persona moral" do
    context "primer_apellido" do
      subject { FactoryBot.build :contribuyente, persona_fisica: false, rfc: 'AAA111111AAA' }
      it "no es necesario" do
        subject.primer_apellido = nil
        expect(subject).to be_valid
      end
    end # context primer_apellido

    context "rfc" do
      context "debe ser 12 dígitos" do
        subject { FactoryBot.build :contribuyente, persona_fisica: false, rfc: 'AAAA111111AAA' }
        it "debe ser 12 digitos" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /debe ser de 12 caracteres/
        end
      end # context debe ser 12 dígitos

      context "puede no estar presente" do
        subject { FactoryBot.build :contribuyente, persona_fisica: false, rfc: nil }
        it "debe ser válido" do
          expect(subject).to be_valid
        end
      end

      context "formato no valido" do
        subject { FactoryBot.build :contribuyente, persona_fisica: false, rfc: '1111AAAAAA11' }
        it "no debe ser válido" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /Rfc no es un RFC válido/
        end
      end
    end
  end # describe "Persona moral"
end
