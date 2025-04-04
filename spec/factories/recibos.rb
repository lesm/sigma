FactoryBot.define do
  factory :recibo do
    serie { "A" }
    folio { "1" }
    moneda { "MXN" }
    tipo_comprobante { "I - Ingreso" }
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
    type { "Recibo" }
    factura_global { nil }
  end

  trait :para_nuevo_arqueo do
    after(:build) do |recibo|
      recibo.emisor = build :emisor if recibo.emisor.nil?
      recibo.cajero = build :cajero, caja: nil if recibo.cajero.nil?
      recibo.contribuyente = build :contribuyente
      recibo.conceptos = build_list :concepto, 2, :con_cuenta, cantidad: 2, valor_unitario: 400, importe: 800
      recibo.subtotal = 1600
      recibo.total = 1600
    end
  end

  trait :con_datos_centavos do
    after(:build) do |recibo|
      recibo.emisor = build :emisor if recibo.emisor.nil?
      recibo.cajero = build :cajero, caja: nil if recibo.cajero.nil?
      recibo.contribuyente = build :contribuyente
      recibo.conceptos = build_list :concepto, 1, :con_cuenta, cantidad: 1, valor_unitario: 400.5, importe: 400.5
      recibo.subtotal = 400.5
      recibo.total = 400.5
    end
  end

  trait :para_timbrar do
    after :build do |recibo|
      recibo.emisor = build(:emisor, :con_direccion, rfc: "TCM970625MB1") if recibo.emisor.nil?
      recibo.cajero = build :cajero, :con_contribuyente if recibo.cajero.nil?
      recibo.caja = recibo.cajero.caja
      recibo.contribuyente = build :contribuyente, rfc: "RAA111111AAA" if recibo.contribuyente.nil?
      recibo.conceptos = [build(:concepto, :con_cuenta_rifas), build(:concepto, :con_cuenta_sorteos)]
      recibo.subtotal = 400
      recibo.total = 400
    end
  end

  trait :de_predial do
    after :build do |recibo|
      recibo.emisor = build :emisor, :con_direccion
      recibo.cajero = build :cajero, :con_contribuyente
      recibo.caja = recibo.cajero.caja
      recibo.contribuyente = build :contribuyente, :con_direccion
      recibo.conceptos = [build(:concepto, :predial_urbano)]
      recibo.subtotal = 500
      recibo.total = 500
    end
  end
end
