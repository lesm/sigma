class Comprobante
  class CreaXmlDesdeRespuestaFm < TareaProcesoTimbrado
    def crear
      comprobante.xml = file
      super
    end

    private

    def file
      @xml_file ||= crea_xml_file
    end

    def crea_xml_file
      Tempfile.open("xml_file", Rails.root.join("tmp")) do |f|
        f.write(Nokogiri::XML(respuesta_fm.xml).to_xml)
        f.close
        f
      end
    end
  end
end
