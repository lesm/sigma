require "rails_helper"

RSpec.describe "Cajero Creating a New Contribuyente", type: :system do
  before :each do
    dado_que_hay_un_cajero_logueado_con_una_caja
    dado_que_existen_dos_conceptos_de_cobro
  end

  feature "Creating a new contribuyente" do
    scenario "In set_cuenta view" do
      cuando_cajero_da_click_en_el_link_caja
      cajero_debe_ver_seleccione_al_contribuyente_y_las_cuentas_por_pagar
      cuando_cajero_busca_un_contribuyente_y_no_existe
      cajero_debe_ver_el_boton_agregar_contribuyente
      cuando_cajero_da_click_en_boton_agregar_contributente
      cajero_debe_ver_el_boton_crear_contribuyente
      dado_que_cajero_captura_datos_para_contribuyente
      cuando_cajero_da_click_en_el_boton_crear_contribuyente
      cajero_debe_ver_contribuyente_registrado_correctamente
      cuando_cajero_da_click_en_el_boton_ok
      contribuyente_select_debe_ser_actualizado
      cuentas_por_cobrar_select_debe_ser_enable
      cuando_cajero_da_click_en_el_boton_siguiente
      cajero_debe_permanecer_en_set_cuenta_view
    end
  end

  def cajero_debe_ver_seleccione_al_contribuyente_y_las_cuentas_por_pagar
    expect(page).to have_content("Seleccione al contribuyente y las cuentas por pagar")
  end

  def cuando_cajero_busca_un_contribuyente_y_no_existe
    first(:css, "span.select2-selection").click
    all(:css, "input[class$='select2-search__field']").last.set("Buscando un contribuyente")
  end

  def cajero_debe_ver_el_boton_agregar_contribuyente
    expect(page).to have_button("Agregar contribuyente")
  end

  def cuando_cajero_da_click_en_boton_agregar_contributente
    click_button "Agregar contribuyente"
  end

  def cajero_debe_ver_el_boton_crear_contribuyente
    expect(page).to have_button("Crear Contribuyente")
  end

  def dado_que_cajero_captura_datos_para_contribuyente
    fill_in "Nombre o razon social", with: "Nicolás"
    fill_in "Primer apellido", with: "Maquiavelo"
    fill_in "Calle", with: "Una calle"
    fill_in "Municipio", with: "Un municipio"
    fill_in "Colonia", with: "Una colonia"
    fill_in "Código Postal", with: "68000"
    fill_in "Localidad", with: "Una localidad"

    select "110101 - RIFAS", from: "concepto_ids"
    select "110102 - SORTEOS", from: "concepto_ids"
  end

  def cuando_cajero_da_click_en_el_boton_crear_contribuyente
    click_button "Crear Contribuyente"
  end

  def cajero_debe_ver_contribuyente_registrado_correctamente
     expect(page).to have_content "Contribuyente registrado correctamente"
  end

  def cuando_cajero_da_click_en_el_boton_ok
    click_button "OK"
  end

  def contribuyente_select_debe_ser_actualizado
    sleep 0.3
    expect(page.all("select#cuenta_form_contribuyente_id option").map(&:text)).to include "Nicolás Maquiavelo"
  end

  def cuentas_por_cobrar_select_debe_ser_enable
    expect(page).to_not have_css("#cuenta_form_cuenta_ids[disabled]")
  end

  def cuando_cajero_da_click_en_el_boton_siguiente
    click_button "Siguiente"
  end

  def cajero_debe_permanecer_en_set_cuenta_view
    expect(current_path).to eq recibo_step_path(:set_cuenta)
  end
end
