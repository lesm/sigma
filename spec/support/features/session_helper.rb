module Features
  module SessionHelpers
    def sign_in_cajero
      contribuyente = create :contribuyente, :con_direccion
      cajero = create :cajero, contribuyente: contribuyente, caja: nil
      visit new_usuario_session_path
      fill_in "usuario_username", with: cajero.username
      fill_in "usuario_password", with: cajero.password
      click_button "Iniciar Sesión"
    end

    def log_out_cajero
      click_link "Cerrar Sesión"
      click_button "Sí"
    end
  end
end
