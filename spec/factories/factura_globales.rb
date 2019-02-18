FactoryBot.define do
  factory :factura_global do
    serie { "A" }
    folio { "1" }
    moneda { "MXN" }
    tipo_comprobante { "Factura" }
    lugar_expedicion { "68300" }
    metodo_pago { "PUE - Pago en una sola exhibición" }
    forma_pago { "01 - Efectivo" }
    subtotal { 2500 }
    descuento { 0 }
    total { 2500 }
    cbb { nil }
    xml { nil }
    pdf { nil }
    estado { "sin_timbre" }
    respuesta_timbrado { nil }
    motivo_descuento { "por pago puntual" }
    fecha_emision { Date.current }
    observaciones { "pago puntual" }
    uso_cfdi { "P01 - Por definir" }
    cajero { nil }
    contribuyente { nil }
    emisor { nil }
    arqueo { nil }
    type { "FacturaGlobal" }
  end

  trait :con_relaciones do
    after :build do |fg|
      fg.emisor = build :emisor
      fg.cajero = build :cajero
      fg.caja = fg.cajero.caja
      fg.contribuyente = build :contribuyente, rfc: "RAA111111AAA"
      fg.conceptos = [build(:concepto, :con_cuenta_rifas), build(:concepto, :con_cuenta_sorteos)]
      fg.subtotal = 400
      fg.total = 400
    end
  end
end
