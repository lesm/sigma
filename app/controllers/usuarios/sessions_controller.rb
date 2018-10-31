# frozen_string_literal: true

class Usuarios::SessionsController < Devise::SessionsController
  # DELETE /resource/sign_out
  def destroy
    current_usuario.caja.abrir!
    super
  end
end
