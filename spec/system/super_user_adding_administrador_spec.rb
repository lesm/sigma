require "rails_helper"

RSpec.describe "SuperUser WorkFlow", type: :system do
  feature "with a super user" do
    scenario "Add a new admin user" do
      dado_que_hay_un_super_user_logueado
      cuando_super_user_da_click_en_link_administrador
      super_user_debe_ser_redireccionado_a_administradores_new
      cuando_super_user_llena_datos_del_formulario_administrador_new
      y_da_click_en_button_crear_administrador
      super_user_debe_ver_mensaje_administrador_fue_creado_correctamente

      cuando_super_user_da_click_en_link_administrador
      super_user_debe_ser_redireccionado_a_administrador_show
      cuando_super_user_da_click_en_link_editar
      cuando_super_user_edita_el_password_del_administrador
      y_da_click_en_button_actualizar_administrador
      super_user_debe_ver_mensaje_administrador_actualizado_correctamente
    end
  end

  def dado_que_hay_un_super_user_logueado
    @super_user = create :usuario,
      nombre: "superuser",
      username: "superuser",
      rol: 4,
      password: "1qaz2wsx"

    sign_in_usuario @super_user
  end

  def cuando_super_user_da_click_en_link_administrador
    click_link "Administrador"
  end

  def super_user_debe_ser_redireccionado_a_administradores_new
    expect(current_path).to eq new_administrador_path
  end

  def cuando_super_user_llena_datos_del_formulario_administrador_new
    fill_in "administrador_nombre", with: "admin"
    fill_in "administrador_username", with: "admin"
    fill_in "administrador_password", with: "1qaz2wsx"
  end

  def y_da_click_en_button_crear_administrador
    click_button "Crear Administrador"
  end

  def super_user_debe_ver_mensaje_administrador_fue_creado_correctamente
    expect(page).to have_content "Administrador fue creado correctamente"
  end

  def cuando_super_user_da_click_en_link_editar
    click_link "Editar"
  end

  def super_user_debe_ser_redireccionado_a_administrador_show
    sleep 0.3
    expect(current_path).to eq administrador_path(Administrador.first)
  end

  def cuando_super_user_edita_el_password_del_administrador
    fill_in "administrador_password", with: "2wsx1qaz"
  end

  def y_da_click_en_button_actualizar_administrador
    click_button "Actualizar Administrador"
  end

  def super_user_debe_ver_mensaje_administrador_actualizado_correctamente
    expect(page).to have_content "Administrador fue actualizado correctamente"
  end
end
