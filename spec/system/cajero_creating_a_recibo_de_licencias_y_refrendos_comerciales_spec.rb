require "rails_helper"

RSpec.describe "Cajero creating a recibo", type: :system do
  feature "Recibo of Licencias y Refrendos Comerciales" do
    scenario "Selecting years correctly of DatosConcepto" do
      dado_que_hay_un_emisor_registrado
      dato_que_hay_un_contribuyente_con_la_cuenta_licencias

      dado_que_hay_un_cajero_logueado_con_una_caja
      cuando_cajero_da_click_en_el_link_caja
      cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps

      cajero_selecciona_un_contribuyente_y_el_concepto_licencias

      cuando_da_click_en_el_link_siguiente
      cajero_es_redireccionado_a_set_conceptos_de_recibo_steps

      dado_que_cajero_captura_datos_de_recibo
      cuando_cajero_da_click_en_boton_cobrar
      cajero_debe_ver_recibo_creado_correctamente
      cajero_debe_ver_anios_de_refrendo_2018_y_2019
    end
  end

  def cajero_debe_ver_recibo_creado_correctamente
    expect(page).to have_content "Recibo fue creado correctamente."
  end

  def cajero_debe_ver_anios_de_refrendo_2018_y_2019
    expect(page).to have_content "Años de Refrendo"
    expect(page).to have_content "2018,2019"
  end
end
