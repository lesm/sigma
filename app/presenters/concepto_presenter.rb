class ConceptoPresenter < SimpleDelegator
  def descuento
    nil
  end

  def valor_unitario
    "%.2f" % super
  end

  def importe
    "%.2f" % super
  end

  def clave
    clave_prod_serv_tabla.key(super)
  end

  def clave_unidad
    clave_unidad_tabla.key(super)
  end

  private

  def clave_prod_serv_tabla
    Concepto::CLAVE_PROD_SERV
  end

  def clave_unidad_tabla
    Concepto::CLAVE_UNIDAD
  end
end
