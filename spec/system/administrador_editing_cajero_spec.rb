require "rails_helper"

RSpec.describe "Administrador Editing Cajero", type: :system do
  feature "Cuando hay un cajero registroda" do
    scenario "Administrador debe poder cambiar username of cajero" do
      dado_que_hay_un_administrador_logueado
      dado_que_hay_un_emisor_registrado
      dado_que_hay_un_cajero_registrado
      cuando_admin_da_click_en_link_cajeros
      admin_debe_ver_el_link_editar
      cuando_admin_da_clink_en_el_link_editar
      admin_debe_ver_el_texto_datos_de_inicio_de_sesion
      dado_que_admin_cambia_el_username_del_cajero
      cuando_admin_da_click_en_boton_actualizar_cajero
      admin_debe_de_ver_contribuyente_actualiado_correctamente
    end
  end

  def dado_que_hay_un_cajero_registrado
    create :cajero, :sin_caja, :con_contribuyente
  end

  def admin_debe_ver_el_link_editar
    expect(page).to have_link "Editar"
  end

  def cuando_admin_da_clink_en_el_link_editar
    click_link "Editar"
  end

  def dado_que_admin_cambia_el_username_del_cajero
    fill_in "cajero_username", with: "new_username"
  end

  def cuando_admin_da_click_en_boton_actualizar_cajero
    click_button "Actualizar Cajero"
  end

  def admin_debe_de_ver_contribuyente_actualiado_correctamente
    expect(page).to have_content "Cajero fue actualizado correctamente."
  end
end
