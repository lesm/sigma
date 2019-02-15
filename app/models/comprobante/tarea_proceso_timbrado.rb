class Comprobante::TareaProcesoTimbrado
  require "tempfile"

  attr_reader :comprobante, :respuesta_fm

  def initialize(comprobante, respuesta_fm)
    @comprobante = comprobante
    @respuesta_fm = respuesta_fm
  end

  def crear
    file.unlink
    comprobante.save
  end

  def file
    raise NotImplementedError
  end
end
