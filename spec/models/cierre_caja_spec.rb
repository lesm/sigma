require 'rails_helper'

RSpec.describe CierreCaja, type: :model do
  it { should validate_presence_of(:monto) }
  it { should belong_to(:usuario) }
  it { should have_many(:arqueos).dependent :destroy }

  describe "#monto" do
    context "actualiza monto despues de agregar un arqueo" do
      let(:usuario) { FactoryBot.create :usuario }
      let(:arqueo) { FactoryBot.build :arqueo, monto: 10 }
      let(:arqueo_2) { FactoryBot.build :arqueo, monto: 40 }
      let(:cierre_caja) do
        FactoryBot.create :cierre_caja, usuario: usuario, arqueos: [arqueo]
      end
      let(:cierre_caja_2) do
        FactoryBot.create :cierre_caja, usuario: usuario,
          arqueos: [arqueo, arqueo_2]
      end

      it 'debe ser 10' do
        expect(cierre_caja.monto).to eq 10
      end

      it 'debe ser 50' do
        expect(cierre_caja_2.monto).to eq 50
      end
    end
  end
end
