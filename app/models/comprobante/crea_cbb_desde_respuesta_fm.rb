class Comprobante
  class CreaCbbDesdeRespuestaFm < TareaProcesoTimbrado

    def crear
      comprobante.cbb = cbb_image
      cbb_image.unlink
      comprobante.save
    end

    private

    def cbb_image
      @cbb_image ||= crea_cbb_image
    end

    def crea_cbb_image
      require "tempfile"

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
