require "rails_helper"

RSpec.describe "Set conceptos", type: :system do
  feature "Create a Recibo" do
    scenario "Asigna número de folio correctamenta" do
      dado_que_hay_un_cajero_logueado_con_una_caja
      cuando_da_click_en_el_link_caja
      cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      cajero_selecciona_un_contribuyente_y_un_concepto_de_cobro
      cajero_es_redireccionado_a_set_conceptos_de_recibo_steps
      folio_debe_ser_numero_de_emisor_mas_anio_actual_mas_numero_de_caja_mas_numero_de_recibo
      fecha_cobro_debe_ser_igual_a_fecha_actual
    end
  end

  def dado_que_hay_un_cajero_logueado_con_una_caja
    allow(Comprobante::Sugeridor).to receive(:folio).and_return("482181-1")
    create :contribuyente, nombre_o_razon_social: "Carlos",
      primer_apellido: "José",
      segundo_apellido: "Pérez",
      rfc: "AAAA111111AAZ"
    create :cuenta, codigo: "110101", descripcion: "RIFAS", formato: "DatosComun"
    create :emisor, :con_direccion
    sign_in_cajero_with_caja
  end

  def cuando_da_click_en_el_link_caja
    click_link "Caja"
  end

  def cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
    expect(page).to have_current_path(recibo_step_path(:set_cuenta))
  end

  def cajero_selecciona_un_contribuyente_y_un_concepto_de_cobro
    select "Carlos José Pérez - AAAA111111AAZ", from: "Contribuyente"
    select "110101 - DatosComun - RIFAS", from: "cuenta_ids"
    click_button "Siguiente"
  end

  def cajero_es_redireccionado_a_set_conceptos_de_recibo_steps
    expect(page).to have_current_path(/recibo_steps\/set_conceptos/)
  end

  def folio_debe_ser_numero_de_emisor_mas_anio_actual_mas_numero_de_caja_mas_numero_de_recibo
    expect(page).to have_field("Folio", with: "482181-1")
  end

  def fecha_cobro_debe_ser_igual_a_fecha_actual
    expect(page).to have_field("Fecha Cobro", with: Time.current.strftime("%F %H:%M %p").downcase)
  end
end
