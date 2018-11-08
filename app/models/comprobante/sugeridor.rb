class Comprobante::Sugeridor
  def self.folio(caja)
    "#{numero_municipio}#{year_without_century}#{caja.numero}-#{caja.comprobantes.count + 1}"
  end

  private

  def self.numero_municipio
    Emisor.first.numero_municipio
  end

  def self.year_without_century
    Date.current.strftime("%y")
  end
end
