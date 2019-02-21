class Recibo < Comprobante
  attr_accessor :cuenta_ids

  private

  def encolar_timbrado
    self.timbrado_automatico = false
    convertir_recibo_a_factura!
    ComprobanteWorker.perform_async(id)
  end

  def convertir_recibo_a_factura!
    update_column(:type, "Factura") if type == "Recibo"
  end
end
