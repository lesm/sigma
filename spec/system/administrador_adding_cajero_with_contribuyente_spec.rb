require "rails_helper"

RSpec.describe "Administrador Adding Cajero", type: :system do
  feature "Administrador working with Cajeros" do
    scenario "Adding a new cajero with contribuyente" do
      dado_que_hay_un_administrador_logueado
      dado_que_hay_un_emisor_registrado
      dado_que_existen_conceptos_de_cobro
      cuando_admin_da_click_en_link_cajeros
      admin_debe_ver_el_link_agregar_cajero
      cuando_admin_da_click_en_link_agregar_cajero
      admin_debe_ver_el_texto_datos_de_inicio_de_sesion
      dado_que_admin_captura_username_y_password
      cuando_admin_busca_un_contribuyente_y_no_existe
      admin_debe_de_ver_el_boton_agregar_contribuyete
      cuando_admin_da_click_en_boton_agregar_contribuyente
      admin_debe_ver_el_boton_crear_contribuyente
      dado_que_admin_captura_datos_para_contribuyente
      cuando_admin_da_click_en_el_boton_crear_contribuyente
      admin_debe_de_ver_contribuyente_registrado_correctamente
      cuando_admin_da_click_en_el_boton_ok
      contribuyente_select_debe_ser_actualizado
      admin_debe_poder_seleccionar_el_nuevo_contribuyente_agregado
      el_input_nombre_debe_ser_actualizado
      cuando_admin_da_click_en_boton_crear_cajero
      admin_debe_ver_cajero_creado_correctamente
    end
  end

  def dado_que_hay_un_emisor_registrado
    create :emisor, :con_direccion
  end

  def dado_que_existen_conceptos_de_cobro
    create :cuenta, :rifas
    create :cuenta, :sorteos
  end

  def cuando_admin_da_click_en_link_cajeros
    click_link "Cajeros"
  end

  def admin_debe_ver_el_link_agregar_cajero
    expect(page).to have_link("Agregar Cajero")
  end

  def cuando_admin_da_click_en_link_agregar_cajero
    click_link "Agregar Cajero"
  end

  def admin_debe_ver_el_texto_datos_de_inicio_de_sesion
    expect(page).to have_content "DATOS DE INICIO DE SESIÓN"
  end

  def dado_que_admin_captura_username_y_password
    fill_in "cajero_username", with: "Cajero test"
    fill_in "cajero_password", with: "1qaz2wsx"
  end

  def cuando_admin_busca_un_contribuyente_y_no_existe
    find(:css, "span.select2-selection").click
    find(:css, "input[class$='select2-search__field']").set("Buscando un contribuyente")
  end

  def admin_debe_de_ver_el_boton_agregar_contribuyete
    expect(page).to have_button("Agregar contribuyente")
  end

  def cuando_admin_da_click_en_boton_agregar_contribuyente
    click_button "Agregar contribuyente"
  end

  def admin_debe_ver_el_boton_crear_contribuyente
    expect(page).to have_button("Crear Contribuyente")
  end

  def dado_que_admin_captura_datos_para_contribuyente
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

  def cuando_admin_da_click_en_el_boton_crear_contribuyente
    click_button "Crear Contribuyente"
  end

  def admin_debe_de_ver_contribuyente_registrado_correctamente
     expect(page).to have_content "Contribuyente registrado correctamente"
  end

  def cuando_admin_da_click_en_el_boton_ok
    click_button "OK"
  end

  def contribuyente_select_debe_ser_actualizado
    sleep 0.3
    expect(page.all("select#cajero_contribuyente_id option").map(&:text)).to include "Nicolás Maquiavelo"
  end

  def admin_debe_poder_seleccionar_el_nuevo_contribuyente_agregado
    select "Nicolás Maquiavelo", from: "cajero_contribuyente_id"
  end

  def el_input_nombre_debe_ser_actualizado
    expect(page).to have_field("Nombre", with: "Nicolás Maquiavelo")
  end

  def cuando_admin_da_click_en_boton_crear_cajero
    click_button "Crear Cajero"
  end

  def admin_debe_ver_cajero_creado_correctamente
    expect(page).to have_content "Cajero fue creado correctamente."
  end
end
