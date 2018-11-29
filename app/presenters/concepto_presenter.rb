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
end
