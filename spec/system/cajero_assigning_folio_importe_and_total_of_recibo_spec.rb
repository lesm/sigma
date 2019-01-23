require "rails_helper"

RSpec.describe "Cajero Assigning Folio, Importe and Total of Recibo", type: :system do
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

    scenario "Asigna importe y total con decimales aplicando redondeo" do
      cuando_cantidad_es_1_y_precio_unitario_es_9_99
      el_importe_debe_ser_10_y_total_debe_ser_10

      cuando_cantidad_es_1_y_precio_unitario_es_9_53
      el_importe_debe_ser_9_5_y_total_debe_ser_9_5

      cuando_cantidad_es_1_y_precio_unitario_es_9_49
      el_importe_debe_ser_9_5_y_total_debe_ser_9_5
    end
  end

  def cuando_cantidad_es_2_y_precio_unitario_es_100
    fill_in "Cantidad", with: 2
    fill_in "Precio Unitario", with: 100
    fill_in "Observaciones", with: "Para lanzar evento javascript"
  end

  def el_importe_debe_ser_200_y_total_debe_ser_200
    expect(find_field("Importe").value).to eq "200.0"
    expect(find_field("Total").value).to eq "200.0"
  end

  def cuando_cantidad_es_1_y_precio_unitario_es_9_99
    fill_in "Cantidad", with: 1
    fill_in "Precio Unitario", with: 9.99
    fill_in "Observaciones", with: "Para lanzar evento javascript"
  end

  def cuando_cantidad_es_1_y_precio_unitario_es_9_53
    fill_in "Cantidad", with: 1
    fill_in "Precio Unitario", with: 9.53
    fill_in "Observaciones", with: "Para lanzar evento javascript"
  end

  def el_importe_debe_ser_10_y_total_debe_ser_10
    expect(find_field("Importe").value).to eq "10.0"
    expect(find_field("Total").value).to eq "10.0"
  end

  def cuando_cantidad_es_1_y_precio_unitario_es_9_49
    fill_in "Cantidad", with: 1
    fill_in "Precio Unitario", with: 9.49
    fill_in "Observaciones", with: "Para lanzar evento javascript"
  end

  def el_importe_debe_ser_9_5_y_total_debe_ser_9_5
    expect(find_field("Importe").value).to eq "9.5"
    expect(find_field("Total").value).to eq "9.5"
  end

  def folio_debe_ser_numero_de_emisor_mas_anio_actual_mas_numero_de_caja_mas_numero_de_recibo
    numero_caja = @cajero.caja.numero
    expect(page).to have_field("Folio", with: "48219#{numero_caja}-1")
  end

  def fecha_cobro_debe_ser_igual_a_fecha_actual
    expect(page).to have_field("Fecha Cobro", with: Time.current.strftime("%F %H:%M %p").downcase)
  end
end
