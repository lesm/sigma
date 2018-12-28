require "rails_helper"

RSpec.describe FacturaLayout do
  let(:recibo) { create :recibo, :para_timbrar }
  let(:presenter) { ComprobanteLayoutPresenter.new recibo }
  let(:presenter_layout) { FacturaLayout.new presenter }

  let(:factura_layout) do
    <<-RESPONSE
[ComprobanteFiscalDigital]

Version=3.3
Fecha=#{presenter.fecha_emision}
Folio=1
NoCertificado=
SubTotal=400.00
Descuento=
Total=400.00
Serie=A
TipoDeComprobante=I
FormaPago=01
MetodoPago=PUE
Moneda=MXN
LugarExpedicion=68300

[DatosAdicionales]

tipoDocumento=Factura

[Emisor]

Rfc=AAA111111AAA
Nombre=HUAJUAPAN DE LEÓN
RegimenFiscal=603

[Receptor]

Rfc=RAA111111AAA
Nombre=Pedro
UsoCFDI=P01

[Concepto#1]

Cantidad=1.0
ClaveProdServ=93161700
ClaveUnidad=E48
Descripcion=Pago de rifas
ValorUnitario=100.00
Importe=100.00
Descuento=

[Concepto#2]

Cantidad=2.0
ClaveProdServ=93161700
ClaveUnidad=E48
Descripcion=Pago de sorteos
ValorUnitario=150.00
Importe=300.00
Descuento=

    RESPONSE
  end

  describe "#to_s" do
    it "displays in layout format" do
      expect(presenter_layout.to_s.gsub("\r", "").strip).to eq factura_layout.strip
    end
  end
end
