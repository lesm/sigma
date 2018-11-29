require "rails_helper"

RSpec.describe "Pages index", type: :system do
  let(:contribuyente) { create :contribuyente, :con_direccion }
  let(:cajero) { create :cajero, username: "cajero", contribuyente: contribuyente }

  feature "Visit root page" do
    scenario "botón iniciar sesión" do
      visit root_path
      expect(page).to have_content "Iniciar Sesión"
    end
  end

  feature "Seleccionar caja" do

    before :each do
      dado_que_hay_almenos_una_caja_disponible
      y_usuario_se_loguea_como_cajero
      cajero_es_redireccionado_a_seleccinar_caja_path
    end

    scenario "liberar caja para otro cajero" do
      cuando_cajero_seleciona_una_caja
      caja_seleccinada_se_asigna_al_cajero
      la_caja_debe_cambiar_a_no_disponible
      cajero_crea_un_arqueo_en_ceros
      cajero_cierra_cierre_de_caja_en_ceros
      cuando_cajero_cierra_sesion
      la_caja_debe_cambiar_a_disponible
    end

    scenario "debe ser redireccionado a seleccionar caja" do
      y_cajero_no_selecciona_caja_y_da_click_en_otro_link
      debe_ser_redireccionado_a_seleccionar_caja_path
    end
  end

  def y_usuario_se_loguea_como_cajero
    sign_in_cajero
  end

  def cajero_es_redireccionado_a_seleccinar_caja_path
    expect(page).to have_current_path(new_historial_caja_path)
  end

  def la_caja_debe_cambiar_a_no_disponible
    expect(@caja.reload).to_not be_disponible
  end

  def cajero_crea_un_arqueo_en_ceros
    cajero_da_click_en_link_recaudacion
    cajero_da_click_en_link_crear_arqueo
    cajero_da_click_en_boton_crear_arqueo
  end

  def cajero_cierra_cierre_de_caja_en_ceros
    cajero_da_click_en_link_cierre_de_caja
    cajero_da_click_en_el_link_ver
    cajero_da_click_en_link_cerrar_caja
    cajero_da_click_en_confirmar_cerrar_caja
  end

  def cajero_da_click_en_link_cerrar_caja
    click_link "Cerrar caja"
  end

  def cajero_da_click_en_confirmar_cerrar_caja
    click_button "Sí"
  end

  def y_cajero_no_selecciona_caja_y_da_click_en_otro_link
    click_link "Caja"
  end

  def debe_ser_redireccionado_a_seleccionar_caja_path
    cajero_es_redireccionado_a_seleccinar_caja_path
  end

  def cuando_cajero_cierra_sesion
    log_out_cajero
    expect(page).to have_content "Iniciar Sesión"
  end

  def la_caja_debe_cambiar_a_disponible
    expect(@caja.reload).to be_disponible
  end
end

