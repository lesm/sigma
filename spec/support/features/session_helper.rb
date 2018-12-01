module Features
  module SessionHelpers
    def sign_in_cajero
      @cajero = create :cajero, contribuyente: contribuyente, caja: nil
      visit new_usuario_session_path
      fill_in "usuario_username", with: @cajero.username
      fill_in "usuario_password", with: @cajero.password
      click_button "Iniciar Sesión"
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
  end
end
