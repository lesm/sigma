module Features
  module SessionHelpers
    def sign_in_cajero
      @cajero = create :cajero, contribuyente: contribuyente, caja: nil
      sign_in_usuario @cajero
    end

    def sign_in_admin
      @admin = create :usuario, nombre: "admin", username: "admin",
        rol: 3, password: "1qaz2wsx"
      sign_in_usuario @admin
    end

    def sign_in_cajero_with_caja
      dado_que_hay_almenos_una_caja_disponible
      sign_in_cajero
      cuando_cajero_seleciona_una_caja
      caja_seleccinada_se_asigna_al_cajero
      @cajero.reload
    end

    def dado_que_hay_almenos_una_caja_disponible
      @caja = create :caja, nombre: "Mercado", disponible: true
    end

    def cuando_cajero_seleciona_una_caja
      select "Mercado", from: "Seleccionar Caja"
      click_button "Seleccionar Caja"
    end

    def caja_seleccinada_se_asigna_al_cajero
      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content "Caja en uso: Mercado"
    end

    def contribuyente
      create :contribuyente, :con_direccion
    end

    def log_out_cajero
      click_link "Cerrar sesión"
      click_button "Sí"
    end

    private

    def sign_in_usuario usuario
      visit new_usuario_session_path
      fill_in "usuario_username", with: usuario.username
      fill_in "usuario_password", with: usuario.password
      click_button "Iniciar Sesión"
    end
  end
end
