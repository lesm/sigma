class ComprobanteLayoutPresenter < SimpleDelegator
  INGRESO = 'I'

  def fecha_emision
    I18n.l super, format: :comprobante
  end

  def tipo_comprobante
    INGRESO
  end

  def forma_pago
    Comprobante::FORMA_PAGO.key(super) 
  end

  def metodo_pago
    "PUE" 
  end

  def descuento
    (super == 0) ? nil : ("%.2f" % super)
  end

  def subtotal
    "%.2f" % super 
  end

  def total
    "%.2f" % super 
  end

  def uso_cfdi
    Contribuyente::USO_CFDI.key(super) 
  end
end
