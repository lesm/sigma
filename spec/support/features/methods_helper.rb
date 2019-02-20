module Features
  module MethodsHelpers
    def dado_que_hay_un_contribuyente_una_cuenta_y_un_emisor
      dado_que_hay_un_contribuyente_y_un_emisor
      cuenta = create :cuenta, :rifas
      @contribuyente.cuentas << cuenta
    end

    def dado_que_hay_un_contribuyente_y_un_emisor
      @contribuyente = create :contribuyente, nombre_o_razon_social: "Carlos", primer_apellido: "José",
        segundo_apellido: "Pérez", rfc: "AAAA111111AAZ"
      create :emisor, :con_direccion, rfc: "TCM970625MB1"
    end

    def dado_que_hay_un_cajero_logueado_con_una_caja
      sign_in_cajero_with_caja
    end

    def dado_que_hay_un_administrador_logueado
      sign_in_admin
    end

    def cuando_cajero_da_click_en_el_link_caja
      click_link "Caja"
    end

    def cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      expect(page).to have_current_path(recibo_step_path(:set_cuenta))
    end

    def cajero_selecciona_un_contribuyente_y_un_concepto_de_cobro
      cajero_selecciona_un_contribuyente
      select "110101 - RIFAS", from: "cuenta_form_cuenta_ids"
    end

    def cajero_selecciona_un_contribuyente
      first("span.selection").click
      first("li.select2-results__option", text: "Carlos José Pérez - AAAA111111AAZ").click
    end

    def cuando_da_click_en_el_link_siguiente
      click_button "Siguiente"
    end

    def cajero_es_redireccionado_a_set_conceptos_de_recibo_steps
      expect(page).to have_current_path(/recibo_steps\/set_conceptos/)
    end

    def cuando_cajero_da_click_en_link_de_cerrar_sesion
      click_link "Cerrar sesión"
    end

    def cuando_cajero_da_click_en_confirmar_cerrar_sesion
      click_button "Sí"
    end

    def cuando_admin_da_click_en_link_de_cerrar_sesion
      click_link "Cerrar sesión"
    end

    def cuando_admin_da_click_en_confirmar_cerrar_sesion
      click_button "Sí"
    end

    def cajero_da_click_en_link_recaudacion
      click_link "Recaudación"
    end

    def cajero_da_click_en_link_crear_arqueo
      click_link "Crear arqueo"
    end

    def cajero_da_click_en_link_cierre_de_caja
      click_link "Cierre de caja"
    end

    def cajero_da_click_en_boton_crear_arqueo
      click_button "Crear Arqueo"
    end

    def cajero_da_click_en_link_cerrar_caja
      click_link "Cerrar caja"
      sleep 1
    end

    def cajero_da_click_en_confirmar_cerrar_caja
      click_button "Sí"
      click_button "OK"
    end

    def cajero_da_click_en_link_ver
      click_link "Ver"
      sleep 1
    end

    def se_muestra_un_mensaje_de_cierre_de_sesion
      expect(page).to have_content "Sesión cerrada exitosamente."
    end

    def dado_que_hay_un_emisor_registrado
      create :emisor, :con_direccion, rfc: "TCM970625MB1"
    end

    def cuando_admin_da_click_en_link_cajeros
      click_link "Cajeros"
    end

    def admin_debe_ver_el_texto_datos_de_inicio_de_sesion
      expect(page).to have_content "DATOS DE INICIO DE SESIÓN"
    end

    def cuando_cajero_da_click_en_boton_cobrar
      click_button "Cobrar"
    end

    def dado_que_existen_dos_conceptos_de_cobro
      create :cuenta, :rifas
      create :cuenta, :sorteos
    end

    def dato_que_hay_un_contribuyente_con_la_cuenta_licencias
      cuenta = create :cuenta, :de_licencias_y_refrendos
      @contribuyente = create :contribuyente, :con_direccion,
        nombre_o_razon_social: "Carlos", primer_apellido: "José",
        segundo_apellido: "Pérez", rfc: "AAAA111111AAZ",
        concepto_ids: [cuenta.id.to_s]
      @contribuyente.cuentas << cuenta
    end

    def cajero_selecciona_un_contribuyente_y_el_concepto_licencias
      cajero_selecciona_un_contribuyente
      select "430601 - LICENCIAS Y REFRENDOS COMERCIAL", from: "cuenta_form_cuenta_ids"
    end

    def dado_que_cajero_captura_datos_de_recibo
      select "Efectivo", from: "Forma de Pago"
      fill_in "Cantidad", with: "2"
      fill_in "Precio Unitario", with: "200"
      find(:css, "input[id$='_attributes_folio']").set("12")
      fill_in "Serie", with: "AA"
      fill_in "Fecha de Refrendo", with: Date.current.to_s
      fill_in "Fecha de Evento", with: Date.current.to_s
      fill_in "Observaciones", with: "Pagando 2018 y 2019"
      select "2018", from: "Años"
      select "2019", from: "Años"
    end

  end
end
