module CuentasHelper
  def cuenta_formatos
    Cuenta.all.each_with_object({}) do |c, obj|
      obj[c.codigo] = c.formato
    end
  end
end
