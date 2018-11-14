FactoryBot.define do
  factory :recibo do
    serie { "A" }
    folio { "1" }
    moneda { "MXN" }
    tipo_comprobante { "Factura" }
    lugar_expedicion { "68300" }
    metodo_pago { "Pago en una sola exhibición" }
    forma_pago { "Efectivo" }
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
    cajero { nil }
    contribuyente { nil }
    emisor { nil }
    arqueo { nil }
    type { "Recibo" }
  end

  trait :con_datos do
    after(:build) do |recibo|
      recibo.emisor = build :emisor
      recibo.cajero = build :cajero, caja: nil
      recibo.contribuyente = build :contribuyente
      recibo.conceptos = build_list :concepto, 1, :con_cuenta, cantidad: 1, valor_unitario: 400, importe: 400
      recibo.subtotal = 400
      recibo.total = 400
    end
  end
end
