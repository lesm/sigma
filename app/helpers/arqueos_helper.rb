module ArqueosHelper
  def cierre_caja_id
    current_usuario.cierre_caja_id
  end

  def cierre_caja_abierta?
    current_usuario.cierre_caja_abierta?
  end

  def arqueo_pendiente?
    current_usuario.arqueo_pendiente?
  end

  def monto_no_efectivo
    current_usuario.monto_no_efectivo
  end

  def monto_sistema
    current_usuario.monto_sistema
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
