class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_seleccionar_caja, if: :cajero_logueado_sin_caja?
  before_action :redirect_to_new_emisor, if: :admin_logueado_sin_emisor?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def redirect_to_seleccionar_caja
    return if cierre_de_sesion?
    redirect_to new_historial_caja_path and return
  end

  def redirect_to_new_emisor
    return if cierre_de_sesion?
    flash.alert = "Debes registrar un Municipio."
    redirect_to new_emisor_path and return
  end

  def cierre_de_sesion?
    controller_name == "sessions" and action_name == "destroy"
  end

  def cast_value value
    ActiveRecord::Type::Boolean.new.cast(value)
  end

  def current_user
    current_usuario
  end

  def user_not_authorized
    flash[:alert] = "Usuario no autorizado para esta acción."
    redirect_to(request.referrer || root_path)
  end

  def after_sign_in_path_for(resource)
    if current_usuario.cajero?
      flash.keep(:notice)
      return redirige_a_new_arqueo if cajero_con_arqueo_pendiente?
      return redirige_a_cierre_caja if cajero_con_cierre_caja_pendiente?
      recibo_step_path(:set_cuenta)
    else
      super
    end
  end

  protected

  def load_cuentas_contribuyente
    ids_cuentas          = @contribuyente.cuenta_ids
    @cuentas_asignadas   = Cuenta.where(id: ids_cuentas).map { |c| [c, c.id] }
    @cuentas_por_asignar = Cuenta.where.not(id: ids_cuentas).map { |c| [c, c.id] }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  def generar_pdf(nombre)
    {
      pdf: nombre_pdf,
      page_size: "Letter",
      template: "pdfs/#{nombre}.pdf.haml",
      viewport_size: "1280x1024",
      margin: { top: "30", bottom: "20" },
      header: { html: { template: "layouts/pdfs/_header.pdf.haml" } },
      footer: { html: { template: "layouts/pdfs/_footer.pdf.haml" } }
    }
  end

  private

  def admin_logueado_sin_emisor?
    return false unless usuario_signed_in?
    current_usuario.admin? and Emisor.count == 0
  end

  def cajero_logueado_sin_caja?
    usuario_signed_in? &&
      current_usuario.cajero? &&
      current_usuario.caja.nil?
  end

  def redirige_a_new_arqueo
    flash.alert = "Hay un arqueo pendiente..."
    new_arqueo_path
  end

  def redirige_a_cierre_caja
    flash.alert = "Hay un cierre de caja pendiente..."
    current_usuario.ultimo_cierre_caja
  end

  def cajero_con_arqueo_pendiente?
    cajero_con_caja? and current_usuario.arqueo_pendiente?
  end

  def cajero_con_cierre_caja_pendiente?
    cajero_con_caja? and current_usuario.cierre_caja_abierta?
  end

  def cajero_con_caja?
    current_usuario.caja.present?
  end
end
