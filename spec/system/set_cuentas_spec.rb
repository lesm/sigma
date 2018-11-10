require "rails_helper"

RSpec.describe "Set cuentas", type: :system do
  feature "Seleccionando cuentas" do
    scenario "Muestra mensaje de error" do
      dado_que_hay_un_cajero_logueado_con_una_caja
      cuando_da_click_en_el_link_caja
      cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      cuando_da_click_en_el_link_siguiente
      debe_mostrar_mensaje_de_error
    end
  end

  def debe_mostrar_mensaje_de_error
    expect(page).to have_content "Contribuyente no puede estar en blanco"
  end
end
