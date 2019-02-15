class Comprobante::CreaXmlDesdeRespuestaFm
  attr_reader :comprobante, :respuesta_fm

  def initialize(comprobante, respuesta_fm)
    @comprobante = comprobante
    @respuesta_fm = respuesta_fm
  end

  def crear
    comprobante.xml = xml_file
    xml_file.unlink
    comprobante.save
  end

  private

  def xml_file
    @xml_file ||= crea_xml_file
  end

  def crea_xml_file
    require "tempfile"

    Tempfile.open("xml_file", Rails.root.join("tmp")) do |f|
      f.write(Nokogiri::XML(respuesta_fm.xml).to_xml)
      f.close
      f
    end
  end
end
