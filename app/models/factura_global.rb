class FacturaGlobal < Comprobante
  attr_accessor :fecha_inicio, :fecha_fin

  has_many :recibos

  private

  def encolar_timbrado
    self.timbrado_automatico = false
    ComprobanteWorker.perform_async(id)
  end
end
