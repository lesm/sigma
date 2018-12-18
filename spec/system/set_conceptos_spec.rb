require "rails_helper"

RSpec.describe "Set conceptos", type: :system do
  feature "En nuevo Recibo" do
    before :each do
      dado_que_hay_un_contribuyente_una_cuenta_y_un_emisor
      dado_que_hay_un_cajero_logueado_con_una_caja
      cuando_cajero_da_click_en_el_link_caja
      cajero_debe_ser_redireccionado_a_set_cuenta_de_recibos_steps
      cajero_selecciona_un_contribuyente_y_un_concepto_de_cobro
      cuando_da_click_en_el_link_siguiente
      cajero_es_redireccionado_a_set_conceptos_de_recibo_steps
    end

    scenario "Asigna número de folio correctamenta" do
      folio_debe_ser_numero_de_emisor_mas_anio_actual_mas_numero_de_caja_mas_numero_de_recibo
      fecha_cobro_debe_ser_igual_a_fecha_actual
    end

    scenario "Asigna importe y total" do
      cuando_cantidad_es_2_y_precio_unitario_es_100
      el_importe_debe_ser_200_y_total_debe_ser_200
    end
  end

  def cuando_cantidad_es_2_y_precio_unitario_es_100
    fill_in "Cantidad", with: 2
    fill_in "Precio Unitario", with: 100
    fill_in "Observaciones", with: "Hola"
  end

  def el_importe_debe_ser_200_y_total_debe_ser_200
    expect(find_field("Importe").value).to eq "200"
    expect(find_field("Total").value).to eq "200"
  end

  def folio_debe_ser_numero_de_emisor_mas_anio_actual_mas_numero_de_caja_mas_numero_de_recibo
    numero_caja = @cajero.caja.numero
    expect(page).to have_field("Folio", with: "48218#{numero_caja}-1")
  end

  def fecha_cobro_debe_ser_igual_a_fecha_actual
    expect(page).to have_field("Fecha Cobro", with: Time.current.strftime("%F %H:%M %p").downcase)
  end
end
