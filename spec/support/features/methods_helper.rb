module Features
  module MethodsHelpers
    def dado_que_hay_un_cajero_logueado_con_una_caja
      sign_in_cajero_with_caja
    end

    def cuando_da_click_en_el_link_caja
      click_link "Caja"
    end

    def cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      expect(page).to have_current_path(recibo_step_path(:set_cuenta))
    end

    def cuando_da_click_en_el_link_siguiente
      click_button "Siguiente"
    end
  end
end
