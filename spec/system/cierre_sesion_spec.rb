require "rails_helper"

RSpec.describe "Cierre de sesión", type: :system do
  feature "Cerrar sesión" do
    feature "Cajero con caja" do
      feature "Cuando cajero no tiene arqueo" do
        scenario "No debe permitir cerrar sesión" do
          dado_que_hay_un_contribuyente_una_cuenta_y_un_emisor
          dado_que_hay_un_cajero_logueado_con_una_caja
          cuando_cajero_da_click_en_link_de_cerrar_sesion
          se_muestra_el_mensaje_debes_crear_un_arqueo
          se_muestra_un_link_de_ir_a_crear_arqueo
        end
      end
    end

    feature "Cajero con caja" do
      feature "Cuando Cajero tiene un arqueo pendiente" do
        before :each do
          dado_que_hay_un_contribuyente_una_cuenta_y_un_emisor
          dado_que_hay_un_cajero_logueado_con_una_caja
          dado_que_cajero_crea_un_recibo
          dado_que_cajero_crea_un_arqueo
          dado_que_cajero_crea_un_recibo
          data_arqueo_pendiente_debe_ser_true
          cuando_cajero_da_click_en_link_de_cerrar_sesion
          se_muestra_un_mensaje_de_arqueo_pendiente
          se_muestra_un_link_de_ir_a_crear_arqueo
        end

        scenario "Cuando cajero omite arqueo" do
          cuando_cajero_da_click_en_cerrar_sesion
          caja_debe_de_seguir_ocupada_por_el_cajero
        end

        feature "Cajero crea arqueo" do
          before :each do
            cuando_cajero_da_click_en_link_ir_a_crear_arqueo
            cajero_debe_ser_redireccionado_a_new_arqueo
            cajero_asigna_datos_para_arqueo
            cajero_da_click_en_boton_crear_arqueo
            data_cierre_caja_abierta_debe_ser_true
            cuando_cajero_da_click_en_link_de_cerrar_sesion
            se_muestra_un_mensaje_de_cierre_de_caja_abierta
            se_muestra_un_link_de_ir_a_cierre_de_caja
          end

          scenario "Cuando cajero decide crear arqueo y no cerrar cierre de caja" do
            cuando_cajero_da_click_en_cerrar_sesion
            caja_debe_de_seguir_ocupada_por_el_cajero
          end

          scenario "Cuando cajero decide crear arqueo y cerrar caja" do
            cuando_cajero_da_click_en_link_ir_a_cierre_de_caja
            cajero_debe_ser_redireccionado_a_la_vista_show_de_cierre_de_caja
            cajero_debe_ver_un_link_de_cerrar_caja
            cuando_cajero_da_click_en_link_cerrar_caja
            se_muestra_un_mensaje_de_confirmar_cerrar_caja
            cuando_cajero_da_click_en_confirmar_cerrar_caja
            data_cierre_caja_abierta_debe_ser_false
            cuando_cajero_da_click_en_link_de_cerrar_sesion
            se_muestra_un_mensaje_de_confirmar_cerrar_sesion
            cuando_cajero_da_click_en_confirmar_cerrar_sesion
            caja_debe_estar_disponible
            actualiza_fecha_cierre_de_ultimo_historial_caja
          end
        end

      end
    end

  end

  def dado_que_cajero_crea_un_recibo
    cuando_cajero_da_click_en_el_link_caja
    cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
    cajero_selecciona_un_contribuyente_y_un_concepto_de_cobro
    cuando_da_click_en_el_link_siguiente
    cajero_es_redireccionado_a_set_conceptos_de_recibo_steps
    cajero_selecciona_forma_pago
    cajero_asigna_precio_unitario
    cajero_asigna_fecha_evento
    cuando_cajero_da_click_en_boton_cobrar
    debe_mostrarse_mensaje_de_recibo_creado_correctamente
  end

  def  cajero_selecciona_forma_pago
    select "Efectivo", from: "Forma de Pago"
  end

  def  cajero_asigna_precio_unitario
    fill_in "Precio Unitario", with: 100
  end

  def  cajero_asigna_fecha_evento
    fill_in "Fecha de Evento", with: Date.current.to_s
  end

  def debe_mostrarse_mensaje_de_recibo_creado_correctamente
    expect(page).to have_content "Recibo fue creado correctamente."
  end

  def data_arqueo_pendiente_debe_ser_true
    expect(find("a#closeSession")['data-arqueo-pendiente']).to eq "true"
  end

  def se_muestra_un_mensaje_de_arqueo_pendiente
    expect(page).to have_content("Tienes un arqueo pendiente")
  end

  def se_muestra_el_mensaje_debes_crear_un_arqueo
    expect(page).to have_content("Debes crear un arqueo")
  end

  def se_muestra_un_link_de_ir_a_crear_arqueo
    find_link "Ír a crear Arqueo"
  end

  def cuando_cajero_da_click_en_cerrar_sesion
    click_button "Cerrar Sesión"
  end

  def caja_debe_de_seguir_ocupada_por_el_cajero
    expect(@cajero.caja.reload).to_not be_nil
    expect(Caja.disponibles?).to be_falsey
  end

  def dado_que_cajero_crea_un_arqueo
    cajero_da_click_en_link_recaudacion
    cajero_da_click_en_link_crear_arqueo
    cajero_asigna_datos_para_arqueo
    cajero_da_click_en_boton_crear_arqueo
  end


  def cuando_cajero_da_click_en_link_ir_a_crear_arqueo
    click_link "Ír a crear Arqueo"
  end

  def cajero_debe_ser_redireccionado_a_new_arqueo
    expect(page).to have_current_path new_arqueo_path
  end

  def cajero_asigna_datos_para_arqueo
    fill_in "$100.00", with: 1
  end

  def se_muestra_un_mensaje_de_cierre_de_caja_abierta
    expect(page).to have_content("Cierre de caja abierta")
  end

  def se_muestra_un_link_de_ir_a_cierre_de_caja
    find_link "Ír a cierre de caja"
  end


  def data_cierre_caja_abierta_debe_ser_true
    expect(find("a#closeSession")['data-cierre-caja-abierta']).to eq "true"
  end

  def cuando_cajero_da_click_en_link_ir_a_cierre_de_caja
    click_link "Ír a cierre de caja"
  end

  def cajero_debe_ser_redireccionado_a_la_vista_show_de_cierre_de_caja
    cierre_caja_id = find("a#closeSession")['data-cierre-caja-id']
    expect(page).to have_current_path cierre_caja_path(cierre_caja_id)
  end

  def cajero_debe_ver_un_link_de_cerrar_caja
    expect(find("#botonCerrar")).to have_content("Cerrar caja")
  end

  def cuando_cajero_da_click_en_link_cerrar_caja
    click_link "Cerrar caja"
  end

  def se_muestra_un_mensaje_de_confirmar_cerrar_caja
    expect(page).to have_content("Una vez cerrada la caja ya no se puede abrir.")
  end

  def cuando_cajero_da_click_en_confirmar_cerrar_caja
    click_button "Sí"
  end

  def data_cierre_caja_abierta_debe_ser_false
    sleep 1
    expect(find("a#closeSession")['data-cierre-caja-abierta']).to eq "false"
  end

  def se_muestra_un_mensaje_de_confirmar_cerrar_sesion
    expect(page).to have_content(/\¿Estas seguro\?/)
    expect(page).to have_content(/Cerrar Sesión/)
  end

  def caja_debe_estar_disponible
    expect(@cajero.reload.caja).to be_nil
    expect(Caja.disponibles?).to be_truthy
  end

  def actualiza_fecha_cierre_de_ultimo_historial_caja
    expect(HistorialCaja.count).to eq 1
    expect(HistorialCaja.last.fecha_cierre).to_not be_nil
  end
end
