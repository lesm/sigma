require "rails_helper"

RSpec.describe "Administrador creating Emisor", type: :system do
  feature "when there is no a Emisor" do
    before :each do
      dado_que_hay_un_administrador_logueado
    end

    scenario "there should be a message" do
      debe_haber_un_mensaje_de_registrar_un_municipio
      debe_ser_redireccionado_a_new_emisor_path
    end

    scenario "redirect_to new_emisor_path after click any link" do
      cuando_admin_da_click_en_link_cajeros
      debe_ser_redireccionado_a_new_emisor_path
    end

    scenario "allow to close session whitout register a emisor" do
      cuando_admin_da_click_en_link_de_cerrar_sesion
      cuando_admin_da_click_en_confirmar_cerrar_sesion
      se_muestra_un_mensaje_de_cierre_de_sesion
    end

    scenario "allow to navigate after register a emisor" do
      dado_que_admin_captura_datos_para_municipio
      cuando_admin_da_click_en_boton_crear_municipio
      se_muestra_un_mensaje_de_municipio_creado_correctamente
      debe_ser_redireccionado_correctamente_a_new_activar_certificado_path
    end
  end

  def cuando_admin_da_click_en_link_cajeros
    click_link "Cajeros"
  end

  def debe_ser_redireccionado_a_new_emisor_path
    expect(page).to have_current_path(new_emisor_path)
  end


  def dado_que_admin_captura_datos_para_municipio
    fill_in "Nombre", with: "Huajuapan de León"
    fill_in "RFC", with: "AAAA111111AA"
    fill_in "Eslogan", with: "En un minuto hay muchos días"
    fill_in "Número Municipio", with: "10"
    fill_in "Calle", with: "Hidalgo"
    fill_in "Número", with: "s/n"
    fill_in "Colonia", with: "Centro"
    fill_in "Código Postal", with: "68000"
    fill_in "Localidad", with: "Centro"
    find(:css, "input[id$='_attributes_municipio']").set("Huajuapan de León")
    attach_file("Logotipo", Rails.root + "spec/fixtures/files/logotipo.png")
    attach_file("Escudo", Rails.root + "spec/fixtures/files/escudo.png")
  end

  def debe_haber_un_mensaje_de_registrar_un_municipio
    expect(page).to have_content "Debes registrar un Municipio."
  end

  def cuando_admin_da_click_en_boton_crear_municipio
    click_button "Crear Municipio"
  end

  def se_muestra_un_mensaje_de_municipio_creado_correctamente
    expect(page).to have_content "Municipio fue creado correctamente."
  end

  def debe_ser_redireccionado_correctamente_a_cajeros_path
    expect(page).to have_current_path(cajeros_path)
  end

  def debe_ser_redireccionado_correctamente_a_new_activar_certificado_path
    expect(current_path).to eq new_activar_certificado_path
  end
end
