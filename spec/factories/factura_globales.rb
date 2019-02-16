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
end
