class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_seleccionar_caja
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def redirect_to_seleccionar_caja
    if cajero_logueado_sin_caja?
      redirect_to new_historial_caja_path and return
    end
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

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  private

  def cajero_logueado_sin_caja?
    usuario_signed_in? &&
      current_usuario.cajero? &&
      current_usuario.caja.nil?
  end
end
