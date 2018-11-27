require "rails_helper"

RSpec.describe "Inicio de Sesión", type: :system do
  feature "Iniciar sesión cajero" do
    scenario "Cuando Cajero incia sesión sin caja" do
      dado_que_existe_un_cajero_y_una_caja
      cuando_cajero_visita_root_path
      cuando_cajero_da_click_en_link_iniciar_sesion
      cajero_es_redireccionado_a_sing_in
      cajero_ingresa_username_y_password
      cuando_cajero_da_click_en_boton_iniciar_sesion
      cajero_debe_ser_redireccionado_a_historial_cajas_new
    end

    feature "Cuando Cajero incia sesión con caja" do
      before :each do
        dado_que_existe_un_cajero_y_una_caja
        dado_que_cajero_tiene_asignada_una_caja
      end

      scenario "Cuando cajero tiene un arqueo pendiente" do
        dado_que_cajero_tiene_un_arqueo_pendiente
        cuando_cajero_visita_root_path
        cuando_cajero_da_click_en_link_iniciar_sesion
        cajero_es_redireccionado_a_sing_in
        cajero_ingresa_username_y_password
        cuando_cajero_da_click_en_boton_iniciar_sesion
        cajero_debe_ser_redireccionado_a_arqueos_new
        cajero_debe_ver_mensaje_de_arqueo_pendiente
      end

      scenario "Cuando cajero tiene un cierre de caja pendiente" do
        dado_que_cajero_tiene_un_cierre_caja_pendiente
        cuando_cajero_visita_root_path
        cuando_cajero_da_click_en_link_iniciar_sesion
        cajero_es_redireccionado_a_sing_in
        cajero_ingresa_username_y_password
        cuando_cajero_da_click_en_boton_iniciar_sesion
        cajero_debe_ser_redireccionado_a_cierre_caja_show
        cajero_debe_ver_mensaje_de_cierre_caja_pendiente
      end
    end
  end

  def dado_que_existe_un_cajero_y_una_caja
    @cajero = create :cajero, :con_contribuyente,
      username: "cajero", caja: nil
    @caja = create :caja, nombre: "Mercado", disponible: true
  end

  def cuando_cajero_visita_root_path
    visit root_path
  end

  def cuando_cajero_da_click_en_link_iniciar_sesion
    click_link "Iniciar Sesión"
  end

  def cajero_es_redireccionado_a_sing_in
    expect(current_path).to eq new_usuario_session_path
  end

  def cajero_ingresa_username_y_password
    fill_in "usuario_username", with: "cajero"
    fill_in "usuario_password", with: "1qaz2wsx"
  end

  def cuando_cajero_da_click_en_boton_iniciar_sesion
    click_button "Iniciar Sesión"
  end

  def cajero_debe_ser_redireccionado_a_historial_cajas_new
    expect(current_path).to eq new_historial_caja_path
  end


  def dado_que_cajero_tiene_asignada_una_caja
    @caja.update_column(:cajero_id, @cajero.id)
    @cajero.reload
  end

  def dado_que_cajero_tiene_un_arqueo_pendiente
    create :recibo, :con_datos, cajero: @cajero,
      caja: @cajero.caja
  end

  def cajero_debe_ser_redireccionado_a_arqueos_new
    expect(current_path).to eq new_arqueo_path
  end

  def cajero_debe_ver_mensaje_de_arqueo_pendiente
    expect(page).to have_content("Hay un arqueo pendiente...")
  end

  def dado_que_cajero_tiene_un_cierre_caja_pendiente
    @cierre_caja = create :cierre_caja, :with_arqueo,
      cajero: @cajero, abierta: true
  end

  def cajero_debe_ser_redireccionado_a_cierre_caja_show
    expect(current_path).to eq cierre_caja_path(@cierre_caja)
  end

  def cajero_debe_ver_mensaje_de_cierre_caja_pendiente
    expect(page).to have_content("Hay un cierre de caja pendiente...")
  end
end
