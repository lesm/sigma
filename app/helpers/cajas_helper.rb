module CajasHelper
  def disponible?(caja = @caja)
    caja.disponible? ? "Disponible" : "No disponible"
  end
end
