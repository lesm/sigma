class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_seleccionar_caja

  def redirect_to_seleccionar_caja
    if usuario_signed_in? && current_usuario.caja.nil?
      redirect_to new_historial_caja_path and return
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end
end
