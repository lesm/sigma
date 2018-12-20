require "rails_helper"

RSpec.describe "Cajero Selecting And Creating Cuentas", type: :system do
  feature "En nuevo Recibo" do
    scenario "Seleccionar y actualizar conceptos de cobro" do
      dado_que_existen_tres_conceptos_de_cobro
      dado_que_hay_un_contribuyente_y_un_emisor
      dado_que_hay_un_cajero_logueado_con_una_caja
      cuando_cajero_da_click_en_el_link_caja
      cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      cajero_selecciona_un_contribuyente
      cuando_cajero_ingresa_un_texto_en_el_input_cuentas_por_cobrar
      cajero_debe_ver_el_boton_relacionar_cuenta
      cuando_cajero_da_click_en_boton_relacionar_cuenta
      cajero_debe_ver_el_boton_crear_relacion
      cuando_cajero_selecciona_el_concepto_sorteos_y_da_click_en_el_boton_crear_relacion
      concepto_sorteos_debe_ser_agregado_a_optios_cuenta_ids
      cajero_debe_poder_seleccionar_el_concepto_sorteos

      cuando_da_click_en_el_link_siguiente
      cajero_debe_ver_la_leyenda_pagar_recibo_a_nombre_de
      cuando_cajero_da_click_en_el_link_regresar
      cajero_debe_tener_el_concepto_110102_sorteos_seleccionado

      cuando_cajero_ingresa_un_texto_en_el_input_cuentas_por_cobrar
      cajero_debe_ver_el_boton_relacionar_cuenta
      cuando_cajero_da_click_en_boton_relacionar_cuenta
      cajero_debe_ver_el_boton_crear_relacion
      cuando_cajero_selecciona_el_concepto_loterias_y_da_click_en_el_boton_crear_relacion
      concepto_loterias_debe_ser_agregado_a_options_cuenta_ids
      cajero_debe_tener_el_concepto_110102_sorteos_seleccionado
      cajero_debe_poder_seleccionar_el_concepto_loterias

      cuando_da_click_en_el_link_siguiente
      cajero_debe_ver_la_leyenda_pagar_recibo_a_nombre_de
      cuando_cajero_da_click_en_el_link_regresar
      cajero_debe_tener_los_conceptos_110102_sorteos_y_110103_loterias_seleccionados
    end
  end

  def dado_que_existen_tres_conceptos_de_cobro
    create :cuenta, :rifas
    create :cuenta, :sorteos
    create :cuenta, :loterias
  end

  def cuando_cajero_ingresa_un_texto_en_el_input_cuentas_por_cobrar
    find(:css, "input[class$='select2-search__field']").set("Buscando una cuenta")
  end

  def cajero_debe_ver_el_boton_relacionar_cuenta
    expect(page).to have_button("Relacionar cuenta")
  end

  def cuando_cajero_da_click_en_boton_relacionar_cuenta
    click_button "Relacionar cuenta"
  end

  def cajero_debe_ver_el_boton_crear_relacion
    expect(page).to have_button("Crear Relación")
  end

  def cuando_cajero_selecciona_el_concepto_sorteos_y_da_click_en_el_boton_crear_relacion
    select "110102 - SORTEOS", from: "contribuyente_cuenta_ids"
    click_button "Crear Relación"
  end

  def concepto_sorteos_debe_ser_agregado_a_optios_cuenta_ids
    sleep 0.5
    expect(page.all("select#cuenta_ids option").map(&:text)).to include "110102 - SORTEOS"
  end

  def cajero_debe_poder_seleccionar_el_concepto_sorteos
    select "110102 - SORTEOS", from: "cuenta_ids"
  end

  def cajero_debe_ver_la_leyenda_pagar_recibo_a_nombre_de
    expect(page).to have_content "Pagar recibo a nombre de: #{@contribuyente}"
  end

  def cuando_cajero_da_click_en_el_link_regresar
    click_link "Regresar"
  end

  def cajero_debe_tener_el_concepto_110102_sorteos_seleccionado
    expect(page).to have_select("cuenta_ids", selected: "110102 - SORTEOS")
  end

  def cuando_cajero_selecciona_el_concepto_loterias_y_da_click_en_el_boton_crear_relacion
    select "110103 - LOTERÍAS", from: "contribuyente_cuenta_ids"
    click_button "Crear Relación"
  end

  def concepto_loterias_debe_ser_agregado_a_options_cuenta_ids
    sleep 0.5
    expect(page.all("select#cuenta_ids option").map(&:text)).to include "110103 - LOTERÍAS"
  end

  def cajero_debe_poder_seleccionar_el_concepto_loterias
    select "110103 - LOTERÍAS", from: "cuenta_ids"
  end

  def cajero_debe_tener_los_conceptos_110102_sorteos_y_110103_loterias_seleccionados
    expect(page).to have_select("cuenta_ids", selected: ["110102 - SORTEOS", "110103 - LOTERÍAS"])
  end
end
