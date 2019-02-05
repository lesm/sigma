module ApplicationHelper
  def para_super_user?
    current_usuario.super_user?
  end

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

  def contribuyente_for_select contribuyente
    [[contribuyente, contribuyente.id]]
  end

  def cuenta_codigos
    Cuenta.all.map { |c| [c, c.codigo] }
  end

  def cajero_ids
    Cajero.all.map { |c| [c, c.id] }
  end

  ENABLE_CUENTA_IDS_IN_SET_CUENTA = true.freeze

  def previous_url
    if request.referrer =~ /recibo_steps\/set_cuenta/
      recibo_step_path(:set_cuenta,
                       @cuenta_params.merge!(
                         state_cuenta_ids: ENABLE_CUENTA_IDS_IN_SET_CUENTA))
    else
      :back
    end
  end
end
