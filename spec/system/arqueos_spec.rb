require "rails_helper"

RSpec.describe "New Arqueo", type: :system do

  feature "Visiting new_arqueo_path" do
    scenario "Creating a new Arqueo" do
      dado_que_hay_un_cajero_logueado_con_una_caja
      crea_datos_necesarios_para_nuevo_arqueo
      cajero_da_click_en_recaudacion
      cajero_da_click_en_crear_arqueo
      monto_sistema_debe_ser_2000
      monto_efectivo_debe_ser_0
      monto_banco_debe_ser_400
      monto_total_debe_ser_400
      monto_adeudo_por_pagar_debe_ser_1600

      cuando_cajero_agrega_1_moneda_de_10_y_1_moneda_de_20
      cuando_cajero_agrega_1_billete_de_100_y_1_billete_de_200
      monto_efectivo_debe_ser_330
      monto_total_debe_ser_730
      monto_adeudo_por_pagar_debe_ser_1270

      cuando_cajero_agrega_2_billetes_de_500_y_5_billetes_de_50
      cuando_cajero_agrega_1_billete_de_20
      monto_efectivo_debe_ser_1600
      monto_total_debe_ser_2000
      debe_haber_una_leyenda_de_monto_correcto

      cuando_cajero_da_click_en_crear_arqueo
      debe_mostrar_mensaje_de_arqueo_creado_correctamente
      debe_haber_una_leyenda_de_monto_sistema
      debe_haber_una_leyenda_de_monto_cajero
    end
  end

  def crea_datos_necesarios_para_nuevo_arqueo
    emisor = create :emisor, :con_direccion
    create :recibo, :con_datos,
      cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil,
      forma_pago: "Cheque nominativo"
    create :recibo, :para_nuevo_arqueo,
      cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil
  end

  def cajero_da_click_en_recaudacion
    click_link "Recaudación"
  end

  def cajero_da_click_en_crear_arqueo
    click_link "Crear Arqueo"
  end

  def monto_sistema_debe_ser_2000
    expect(find_field("Monto sistema").value).to eq "2000.0"
  end

  def monto_efectivo_debe_ser_0
    expect(page).to have_content "Monto Efectivo"
    expect(page).to have_content "$0.00"
  end

  def monto_banco_debe_ser_400
    expect(page).to have_content "Monto Banco"
    expect(page).to have_content "$400.00"
  end

  def monto_total_debe_ser_400
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$400.00"
  end

  def monto_adeudo_por_pagar_debe_ser_1600
    expect(page).to have_content "Adeudo por pagar"
    expect(page).to have_content "$1,600.00"
  end

  def cuando_cajero_agrega_1_moneda_de_10_y_1_moneda_de_20
    fill_in("$10.00", with: 1)
    find(:css, "input[id$='_veinte_m_pesos']").set(1)
  end

  def cuando_cajero_agrega_1_billete_de_100_y_1_billete_de_200
    fill_in("$100.00", with: 1)
    fill_in("$200.00", with: 1)
    fill_in "Observación", with: "Para lanzar evento javascript.."
  end

  def monto_efectivo_debe_ser_330
    expect(page).to have_content "Monto Efectivo"
    expect(page).to have_content "$330.00"
  end

  def monto_total_debe_ser_730
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$730.00"
  end

  def monto_adeudo_por_pagar_debe_ser_1270
    expect(page).to have_content "Adeudo por pagar"
    expect(page).to have_content "$1,270.00"
  end

  def cuando_cajero_agrega_2_billetes_de_500_y_5_billetes_de_50
    fill_in("$500.00", with: 2)
    fill_in("$50.00", with: 5)
  end

  def cuando_cajero_agrega_1_billete_de_20
    find(:css, "input[id$='_veinte_pesos']").set(1)
    fill_in "Observación", with: "Para lanzar evento javascript.."
  end

  def monto_efectivo_debe_ser_1600
    expect(page).to have_content "Monto Efectivo"
    expect(page).to have_content "$1,600.00"
  end

  def monto_total_debe_ser_2000
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$2,000.00"
  end

  def debe_haber_una_leyenda_de_monto_correcto
    expect(page).to have_content "Monto correcto"
  end

  def cuando_cajero_da_click_en_crear_arqueo
    click_button("Crear Arqueo")
  end

  def debe_mostrar_mensaje_de_arqueo_creado_correctamente
    expect(page).to have_content "Arqueo se creo correctamente."
  end

  def debe_haber_una_leyenda_de_monto_sistema
    expect(page).to have_content "Monto (SISTEMA): $2,000.00"
  end

  def debe_haber_una_leyenda_de_monto_cajero
    expect(page).to have_content "Monto (CAJERO): $2,000.00"
  end
end
