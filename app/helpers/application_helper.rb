module ApplicationHelper
  def para_admin?
    current_usuario.admin?
  end

  def para_cajero?
    current_usuario.cajero?
  end

  def cierre_caja_id
    current_usuario.cierre_caja_id
  end

  def cierre_caja_abierta?
    current_usuario.cierre_caja_abierta?
  end

  def sin_arqueo?
    current_usuario.sin_arqueo?
  end

  def con_caja?
    current_usuario.caja.present?
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

  def cuenta_ids
    Cuenta.all.map { |c| [c, c.id] }
  end

  def contribuyente_ids
    Contribuyente.all.map { |c| [c, c.id] }
  end

  def cuenta_codigos
    Cuenta.all.map { |c| [c, c.codigo] }
  end

  def cajero_ids
    Cajero.all.map { |c| [c, c.id] }
  end
end
