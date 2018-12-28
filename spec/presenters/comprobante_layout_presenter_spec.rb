require "rails_helper"

RSpec.describe ComprobanteLayoutPresenter do
  let(:subject) { ComprobanteLayoutPresenter.new recibo }
  let(:recibo) do
    build :recibo, fecha_emision: "2018-11-27".to_date,
      tipo_comprobante: "Factura"
  end

  describe "#fecha_emision" do
    it "receives 2018-11-27 and returns 2018-11-27T00:00:00 " do
      expect(subject.fecha_emision).to eq "2018-11-27T00:00:00"
    end
  end

  describe "#tipo_comprobante" do
    it "receives Factura and returns I" do
      expect(subject.tipo_comprobante).to eq "I"
    end
  end

  describe "#forma_pago" do
    it "receives 'Efectivo' and returns '01'" do
      recibo.forma_pago = "01 - Efectivo"
      expect(subject.forma_pago).to eq "01"
    end

    it "receives 'Cheque nominativo' and returns '02'" do
      recibo.forma_pago = "02 - Cheque nominativo"
      expect(subject.forma_pago).to eq "02"
    end

    it "receives 'Transferencia electrónica de fondos' and returns '03'" do
      recibo.forma_pago = "03 - Transferencia electrónica de fondos"
      expect(subject.forma_pago).to eq "03"
    end

    it "receives 'Tarjeta de crédito' and returns '04'" do
      recibo.forma_pago = "04 - Tarjeta de crédito"
      expect(subject.forma_pago).to eq "04"
    end

    it "receives 'Tarjeta de débito' and returns '28" do
      recibo.forma_pago = "28 - Tarjeta de débito"
      expect(subject.forma_pago).to eq "28"
    end
  end

  describe "#metodo_pago" do
    it "receives 'Pago en una sola exhibición' and returns 'PUE'" do
      expect(subject.metodo_pago).to eq "PUE"
    end
  end

  describe "#descuento" do
    it "receives '0' and returns 'nil'" do
      expect(subject.descuento).to be_nil
    end

    it "receives '10' and returns '10.00'" do
      recibo.descuento = 10
      expect(subject.descuento).to eq "10.00"
    end
  end

  describe "#subtotal" do
    it 'receives 150 and returns 150.00' do
      recibo.subtotal = 150
      expect(subject.subtotal).to eq "150.00"
    end  
  end

  describe "#total" do
    it 'receives 150 and returns 150.00' do
      recibo.total = 150
      expect(subject.total).to eq "150.00"
    end  
  end

  describe "#uso_cfdi" do
    it 'receives 150 and returns 150.00' do
      recibo.uso_cfdi = "P01 - Por definir"
      expect(subject.uso_cfdi).to eq "P01"
    end  
  end
end
