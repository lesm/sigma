require 'rails_helper'

RSpec.describe Contribuyente, type: :model do
  it { should validate_presence_of(:nombre_o_razon_social) }
  it { should validate_presence_of(:primer_apellido) }
  it { should accept_nested_attributes_for(:direccion).allow_destroy(true) }
  it { should have_one(:cajero) }
  it { should have_one(:direccion).dependent(:destroy) }
  it { should have_and_belong_to_many(:cuentas) }
  it { should accept_nested_attributes_for(:direccion).allow_destroy(true) }
  it { should have_many(:recibos) }
  it { should have_many(:facturas) }

  describe "Uniqueness" do
    let(:contribuyente) { create :contribuyente, :con_direccion }
    let(:cuenta_rifas) { create :cuenta, :rifas }

    before :each do
      contribuyente.cuentas << cuenta_rifas
    end

    it "not add relationship" do
      contribuyente.cuentas << cuenta_rifas
      expect(contribuyente.reload.cuentas.count).to eq 1
    end
  end

  describe "#nombre_o_razon_social" do
    let(:contribuyente) do
      create :contribuyente, :con_direccion,
        nombre_o_razon_social: "Octavio",
        primer_apellido: "Paz",
        segundo_apellido: "Lozano"
    end

    let(:cajero) do
      create :cajero, contribuyente: contribuyente,
        nombre: "Octavio Paz Lozano"
    end

    before :each do
      cajero
    end

    context "When contribuyente belongs_to a cajero" do
      context "when nombre_o_razon_social has changed" do
        it "cajero nombre must be updated" do
          contribuyente.nombre_o_razon_social = "Irineo"
          contribuyente.save!
          expect(cajero.reload.nombre).to eq "Irineo Paz Lozano"
        end
      end

      context "when primer_apellido has changed" do
        it "cajero nombre must be updated" do
          contribuyente.primer_apellido = "Fuentes"
          contribuyente.save!
          expect(cajero.reload.nombre).to eq "Octavio Fuentes Lozano"
        end
      end

      context "when segundo_apellido has changed" do
        it "cajero nombre must be updated" do
          contribuyente.segundo_apellido = "Macías"
          contribuyente.save!
          expect(cajero.reload.nombre).to eq "Octavio Paz Macías"
        end
      end

      context "when differents attributes has changed but no nombre_o_razon_social and primer_apellido and segundo_apellido" do
        it "cajero nombre must not be updated" do
          contribuyente.email = "mail@mail.com"
          contribuyente.save!
          expect(cajero.reload.nombre).to eq "Octavio Paz Lozano"
        end
      end
    end
  end

  describe ".persona_fisica" do
    let(:persona_fisica) do
      create :contribuyente, :con_direccion,
        rfc: nil, persona_fisica: true
    end
    let(:not_persona_fisica) do
      create :contribuyente, :con_direccion,
        rfc: nil, persona_fisica: false
    end

    it "when persona_fisica is true" do
      [persona_fisica, not_persona_fisica]
      expect(Contribuyente.persona_fisica).to eq [persona_fisica]
    end

    it "when persona_fisica is false" do
      not_persona_fisica
      expect(Contribuyente.persona_fisica).to eq []
    end
  end

  describe ".search" do
    let(:arturo) do
      create :contribuyente, :con_direccion,
        nombre_o_razon_social: "Arturo",
        primer_apellido: "Perez",
        segundo_apellido: "Valdez",
        rfc: "AAAA111111AAA"
    end
    let(:ramon) do
      create :contribuyente, :con_direccion,
        nombre_o_razon_social: "Ramón",
        primer_apellido: "Martinez",
        segundo_apellido: "Santos",
        rfc: "BBBB111111BBB"
    end
    let(:jose) do
      create :contribuyente, :con_direccion,
        nombre_o_razon_social: "José",
        primer_apellido: "Silva",
        segundo_apellido: "Santos",
        rfc: "CCCC111111CCC"
    end

    before :each do
      [arturo, ramon, jose]
    end

    context "when search for name 'ArTuRo'" do
      it "returns 1 coincidence" do
        expect(Contribuyente.search("ArTuRo").count).to eq 1
      end
    end

    context "when search for primer_apellido 'MarTineZ'" do
      it "returns 1 coincidence" do
        expect(Contribuyente.search("MarTineZ").count).to eq 1
      end
    end

    context "when search for segundo_apellido 'SaNtOs'" do
      it "returns 2 coincidence" do
        expect(Contribuyente.search("SaNtOs").count).to eq 2
      end
    end

    context "when search for rfc 'CCCC111111CCC'" do
      it "returns 2 coincidence" do
        expect(Contribuyente.search("CCCC111111CCC").count).to eq 1
      end
    end

    context "when search for full_name 'José Silva Santos'" do
      it "returns 1 coincidence" do
        expect(Contribuyente.search("José Silva Santos").count).to eq 1
      end
    end

    context "when search for full_name 'José Silvaa Santos'" do
      it "returns 0 coincidences" do
        expect(Contribuyente.search("José Silvaa Santos").count).to eq 0
      end
    end
  end

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
      context "most be 10 o 13 digits" do
        subject { build :contribuyente, rfc: 'AAAA111111AA' }
        it "displays an error message 'debe ser 10 o 13 digitos'" do
          expect(subject).to_not be_valid
          expect(subject.errors.to_a.to_sentence).to match /debe ser de 10 o 13 caracteres/
        end
      end # context debe ser 13 dígitos

      context 'with 10 digits' do
        context "with valid format" do
          subject { build :contribuyente, rfc: 'AAAA111111' }
          it "must be valid" do
            expect(subject).to be_valid
          end
        end

        context "with invalid format" do
          subject { build :contribuyente, rfc: '1111AAAAAA' }
          it "must be invalid" do
            expect(subject).to_not be_valid
          end
        end
      end

      context 'with 13 digits' do
        subject { build :contribuyente, rfc: 'AAAA111111AAA' }
        it "must be valid" do
          expect(subject).to be_valid
        end
      end

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

      context "with formato no valido, valid format starts with letters" do
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
      expect(contribuyente_dos.errors.to_a).to include "Rfc ya ha sido tomado"
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
