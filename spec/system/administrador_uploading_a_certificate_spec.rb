require "rails_helper"

RSpec.describe "Administrador uploading a certificate", type: :system do
  before :each do
    dado_que_hay_un_administrador_logueado
    dado_que_hay_un_emisor_registrado
    given_admin_visit_new_activar_certificado_path
  end

  feature "displays errors" do
    feature "with invalid certificate extension" do
      scenario "shows message 'La extensión del archivo es incorrecta'" do
        when_admin_uploads_an_invalid_extension_certificate
        when_admin_uploads_a_valid_key
        when_admin_enters_a_valid_password
        when_admin_click_submit_button
        then_admin_must_see_an_invalid_extension_message
      end
    end

    feature "with invalid llave extension" do
      scenario "shows message 'La extensión del archivo es incorrecta'" do
        when_admin_uploads_a_valid_certificate
        when_admin_uploads_an_invalid_extension_key
        when_admin_enters_a_valid_password
        when_admin_click_submit_button
        then_admin_must_see_an_invalid_extension_message
      end
    end

    xfeature "with invalid password" do
      scenario "shows message 'La contraseña es incorrecta'" do
        when_admin_uploads_a_valid_certificate
        when_admin_uploads_a_valid_key
        when_admin_enters_an_invalid_password
        when_admin_click_submit_button
        then_admin_must_see_an_invalid_password_message
      end
    end
  end

  feature "when certificate, llave and password are correct" do
    scenario "admin can navigate through the system" do
      given_admin_visit_new_activar_certificado_path
      when_admin_uploads_a_valid_certificate
      when_admin_uploads_a_valid_key
      when_admin_enters_a_valid_password
      when_admin_click_submit_button
      then_admin_must_see_a_message_certificate_was_upload_correctly
    end
  end

  def given_admin_visit_new_activar_certificado_path
    visit new_activar_certificado_path
  end

  def when_admin_uploads_an_invalid_extension_certificate
    attach_file("Certificado", Rails.root + "spec/fixtures/files/certificado.txt")
  end

  def when_admin_uploads_a_valid_key
    attach_file("Llave", Rails.root + "spec/fixtures/files/llave.key")
  end

  def when_admin_enters_a_valid_password
    fill_in "Contraseña", with: "1234578a"
  end

  def when_admin_click_submit_button
    click_button "Activar"
  end

  def then_admin_must_see_an_invalid_extension_message
    expect(page).to have_content("La extensión del archivo es incorrecta")
  end

  def when_admin_uploads_a_valid_certificate
    attach_file("Certificado", Rails.root + "spec/fixtures/files/certificado.cer")
  end

  def when_admin_uploads_an_invalid_extension_key
    attach_file("Llave", Rails.root + "spec/fixtures/files/llave.txt")
  end

  def then_admin_must_see_a_message_certificate_was_upload_correctly
    expect(page).to have_content("Certificado activado correctamente.")
  end
end
