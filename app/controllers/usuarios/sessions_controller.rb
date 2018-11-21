# frozen_string_literal: true

class Usuarios::SessionsController < Devise::SessionsController
  # DELETE /resource/sign_out
  def destroy
    if quitar_relacion_caja?
      current_usuario.caja.abrir!
    end
    super
  end

  private

  def quitar_relacion_caja?
    cast_value(params[:quitar_referencia])
  end
end
