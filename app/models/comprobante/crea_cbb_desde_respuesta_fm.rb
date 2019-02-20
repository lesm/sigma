class Comprobante
  class CreaCbbDesdeRespuestaFm < TareaProcesoTimbrado
    def crear
      comprobante.cbb = file
      super
    end

    private

    def file
      @cbb_image ||= crea_cbb_image
    end

    def crea_cbb_image
      Tempfile.open("cbb_image", Rails.root.join("tmp")) do |f|
        f.write(cbb_fm_encode)
        f.close
        f
      end
    end

    def cbb_fm_encode
      respuesta_fm.cbb.force_encoding('utf-8').encode
    end
  end
end
