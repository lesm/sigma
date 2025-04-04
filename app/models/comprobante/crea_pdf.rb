class Comprobante
  class CreaPdf < TareaProcesoTimbrado
    def crear
      comprobante.pdf = file
      super
    end

    private

    def file
      @pdf_file ||= crea_pdf_file
    end

    def crea_pdf_file
      Tempfile.open("pdf_file", Rails.root.join("tmp")) do |f|
        f.write(pdf_encode)
        f.close
        f
      end
    end

    def pdf_encode
      GenerarPdf.new.generar(comprobante)
        .force_encoding('utf-8').encode
    end
  end
end
