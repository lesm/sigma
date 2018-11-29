class FacturaLayout
  def initialize(factura)
    @factura            = factura
    @emisor             = EmisorPresenter.new @factura.emisor
    @receptor           = @factura.contribuyente
  end

  def to_s
    layout = FmLayout.define_layout do |f|
      encabezado f
      emisor f
      receptor f
      conceptos f
    end
    layout.to_s
  end

private

  def encabezado f
    f.encabezado do |e|
      e.serie @factura.serie
      e.fecha @factura.fecha_emision
      e.folio @factura.folio
      e.tipo_de_comprobante @factura.tipo_comprobante
      e.forma_de_pago @factura.forma_pago
      e.metodo_de_pago @factura.metodo_pago
      e.subtotal @factura.subtotal
      e.descuento @factura.descuento
      e.total @factura.total
      e.moneda @factura.moneda
      e.lugar_de_expedicion @factura.lugar_expedicion
    end
  end

  def emisor f
    f.emisor do |e|
      e.rfc @emisor.rfc
      e.nombre @emisor.nombre
      e.regimen_fiscal @emisor.regimen_fiscal
    end
  end

  def receptor f
    f.receptor do |r|
      r.rfc @receptor.rfc
      r.nombre @receptor.nombre_o_razon_social
      r.uso_cfdi @factura.uso_cfdi
    end
  end

  def conceptos f
    @factura.conceptos.each do |concepto_factura|
      concepto f, ConceptoPresenter.new(concepto_factura)
    end
  end

  def concepto f, concepto
    f.concepto do |c|
      c.clave_producto_servicio concepto.clave
      c.cantidad concepto.cantidad
      c.clave_unidad concepto.clave_unidad
      c.descripcion concepto.descripcion
      c.valor_unitario concepto.valor_unitario
      c.importe concepto.importe
      c.descuento concepto.descuento
    end
  end
end
