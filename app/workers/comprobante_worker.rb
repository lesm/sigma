class ComprobanteWorker
  include Sidekiq::Worker

  def perform(id)
    comprobante = Comprobante.find(id)

    until comprobante.con_respuesta_invalida? or comprobante.con_pdf?
      comprobante.continuar_timbrando!
    end
  end
end
