module Features
  module MethodsHelpers
    def dado_que_hay_un_contribuyente_una_cuenta_y_un_emisor
      create :contribuyente, nombre_o_razon_social: "Carlos",
        primer_apellido: "José",
        segundo_apellido: "Pérez",
        rfc: "AAAA111111AAZ"
      create :cuenta, codigo: "110101", descripcion: "RIFAS", formato: "DatosComun"
      create :emisor, :con_direccion
    end

    def dado_que_hay_un_cajero_logueado_con_una_caja
      sign_in_cajero_with_caja
    end

    def cuando_da_click_en_el_link_caja
      click_link "Caja"
    end

    def cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      expect(page).to have_current_path(recibo_step_path(:set_cuenta))
    end

    def cajero_selecciona_un_contribuyente_y_un_concepto_de_cobro
      select "Carlos José Pérez - AAAA111111AAZ", from: "Contribuyente"
      select "110101 - DatosComun - RIFAS", from: "cuenta_ids"
    end

    def cuando_da_click_en_el_link_siguiente
      click_button "Siguiente"
    end

    def cajero_es_redireccionado_a_set_conceptos_de_recibo_steps
      expect(page).to have_current_path(/recibo_steps\/set_conceptos/)
    end

    def cuando_cajero_da_click_en_link_de_cerrar_sesion
      click_link "Cerrar Sesión"
    end

    def cuando_cajero_da_click_en_confirmar_cerrar_sesion
      click_button "Sí"
    end

    def cajero_da_click_en_link_recaudacion
      click_link "Recaudación"
    end

    def cajero_da_click_en_link_crear_arqueo
      click_link "Crear Arqueo"
    end

    def cajero_da_click_en_link_cierre_de_caja
      click_link "Cierre de Caja"
    end

    def cajero_da_click_en_boton_crear_arqueo
      click_button "Crear Arqueo"
    end

    def cajero_da_click_en_el_link_ver
      click_link "Ver"
      sleep 1
    end
    alias_method :cajero_da_otro_click_en_el_link_ver, :cajero_da_click_en_el_link_ver
  end
end
