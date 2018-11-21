module ArqueosHelper

  def cierre_caja_id cajero = current_usuario
    return nil unless cierre_caja_abierta?(cajero)
    cajero.ultimo_cierre_caja.id
  end

  def cierre_caja_abierta? cajero = current_usuario
    return false if cajero.ultimo_cierre_caja.nil?
    cajero.ultimo_cierre_caja.abierta?
  end

  def arqueo_pendiente? cajero = current_usuario
    return false if cajero.caja.nil?
    monto_sistema(cajero) > 0
  end

  def monto_no_efectivo(cajero)
    Comprobante.monto_no_efectivo(cajero)
  end

  def monto_sistema(cajero)
    Comprobante.total_monto_sistema(cajero)
  end

  def values_body
    attributes_dinero.each_with_object([]) do |(val, attr), array|
      array << @dinero.send(attr) if @dinero.send(attr) > 0
    end
  end

  def labels_header(dinero = @dinero)
    attributes_dinero.each_with_object([]) do |(title, attr), array|
      array << title if @dinero.send(attr) > 0
    end
  end

  def referer_url_cierre_caja
    (request.referer =~ /cierre_cajas/) ?  request.referer : arqueos_path
  end

  private

  def attributes_dinero
    {
      "$0.1"    => "diez_centavos",
      "$0.2"    => "veinte_centavos",
      "$0.5"    => "cincuenta_centavos",
      "$1.0"    => "un_peso",
      "$2.0"    => "dos_pesos",
      "$5.0"    => "cinco_pesos",
      "$10.0"   => "diez_pesos",
      "$20.0"   => "veinte_pesos",
      "$50.0"   => "cincuenta_pesos",
      "$100.0"  => "cien_pesos",
      "$200.0"  => "doscientos_pesos",
      "$500.0"  => "quinientos_pesos",
      "$1000.0" => "mil_pesos",
      "$2000.0" => "dos_mil_pesos"
    }
  end
end
