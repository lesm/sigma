module CierreCajasHelper
  def estado cierre_caja
    cierre_caja.abierta? ? "Abierta" : "Cerrada"
  end
end
