require "rails_helper"

RSpec.describe "New Arqueo", type: :system do

  before :each do
    dado_que_hay_un_cajero_logueado_con_una_caja
  end

  feature "Visiting new_arqueo_path" do
    scenario "Creating a new Arqueo" do
      crea_datos_necesarios_para_nuevo_arqueo
      cajero_da_click_en_link_recaudacion
      cajero_da_click_en_link_crear_arqueo
      monto_sistema_debe_ser_2000_5
      monto_efectivo_debe_ser_0
      monto_banco_debe_ser_400_5
      monto_total_debe_ser_400_5
      monto_adeudo_por_pagar_debe_ser_1600

      cuando_cajero_agrega_1_moneda_de_10_y_1_moneda_de_20
      cuando_cajero_agrega_1_billete_de_100_y_1_billete_de_200
      monto_efectivo_debe_ser_330
      monto_total_debe_ser_730_5
      monto_adeudo_por_pagar_debe_ser_1270

      cuando_cajero_agrega_2_billetes_de_500_y_5_billetes_de_50
      cuando_cajero_agrega_1_billete_de_20
      monto_efectivo_debe_ser_1600
      monto_total_debe_ser_2000_5
      debe_haber_una_leyenda_de_monto_correcto

      cuando_cajero_da_click_en_boton_crear_arqueo
      debe_mostrar_mensaje_de_arqueo_creado_correctamente
      debe_haber_una_leyenda_de_monto_sistema
      debe_haber_una_leyenda_de_monto_cajero
      debe_mostrar_un_subtotal_de_1600_en_monto_efectivo
    end
  end

  feature "Vista show de arqueo" do
    scenario "muestra cantidad de dinero en monedas y billetes" do
      crea_arqueo_de_monedas_y_billetes
      cajero_da_click_en_link_recaudacion
      cajero_da_click_en_link_cierre_de_caja
      cajero_da_click_en_el_link_ver
      cajero_da_otro_click_en_el_link_ver
      debe_mostrar_un_texto_con_la_palabra_monto_efectivo
      debe_mostrar_un_th_con_200
      debe_mostrar_un_th_con_100
      debe_mostrar_un_th_con_10
      debe_mostrar_un_th_con_5
      debe_mostrar_un_total_de_800_en_monto_efectivo
    end

    scenario "muestra cantidad de dinero en [Cheque, Débito, Crédito]" do
      crea_arqueo_de_cheque_debito_credito
      cajero_da_click_en_link_recaudacion
      cajero_da_click_en_link_cierre_de_caja
      cajero_da_click_en_el_link_ver
      cajero_da_otro_click_en_el_link_ver
      debe_mostrar_un_texto_con_la_palabra_monto_no_efectivo
      debe_mostrar_un_th_con_monto_cheque
      debe_mostrar_un_th_con_monto_tarjeta_debito
      debe_mostrar_un_th_con_monto_tarjeta_credito
      debe_mostrar_un_th_con_monto_transferencia
      debe_mostrar_un_subtotal_de_1600_en_monto_no_efectivo
    end
  end

  def crea_datos_necesarios_para_nuevo_arqueo
    emisor = create :emisor, :con_direccion
    create :recibo, :con_datos_centavos,
      cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil,
      forma_pago: "Cheque nominativo"
    create :recibo, :para_nuevo_arqueo,
      cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil,
      forma_pago: "Efectivo"
  end

  def monto_sistema_debe_ser_2000_5
    expect(find_field("Monto sistema").value).to eq "2000.5"
  end

  def monto_efectivo_debe_ser_0
    expect(page).to have_content "Monto Efectivo"
    expect(page).to have_content "$0.00"
  end

  def monto_banco_debe_ser_400_5
    expect(page).to have_content "Monto Banco"
    expect(page).to have_content "$400.50"
  end

  def monto_total_debe_ser_400_5
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$400.50"
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

  def monto_total_debe_ser_730_5
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$730.50"
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

  def monto_total_debe_ser_2000_5
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$2,000.50"
  end

  def debe_haber_una_leyenda_de_monto_correcto
    expect(page).to have_content "Monto correcto"
  end

  def cuando_cajero_da_click_en_boton_crear_arqueo
    click_button("Crear Arqueo")
  end

  def debe_mostrar_mensaje_de_arqueo_creado_correctamente
    expect(page).to have_content "Arqueo se creo correctamente."
  end

  def debe_haber_una_leyenda_de_monto_sistema
    expect(page).to have_content "Monto (SISTEMA): $2,000.50"
  end

  def debe_haber_una_leyenda_de_monto_cajero
    expect(page).to have_content "Monto (CAJERO): $2,000.50"
  end

  def debe_mostrar_un_subtotal_de_1600_en_monto_efectivo
    expect(first("tbody").find("span")).to have_content("$1,600.00")
  end


  def crea_arqueo_de_monedas_y_billetes
    emisor = create :emisor, :con_direccion
    create_list :recibo, 2, :con_datos, cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil, forma_pago: "Efectivo"
    cierre_caja = create :cierre_caja, cajero: @cajero
    dinero = build :dinero, doscientos_pesos: 1, cien_pesos: 5,
      diez_pesos: 5, cinco_pesos: 10, total: 800
    create :arqueo, monto_sistema: 800, monto_cajero: 800,
      cierre_caja: cierre_caja, dinero: dinero
  end

  def debe_mostrar_un_texto_con_la_palabra_monto_efectivo
    expect(page).to have_content "Monto efectivo"
  end

  def debe_mostrar_un_th_con_200
    expect(find("th", text: "$200.0")).to have_content("$200.0")
    expect(find("table.first").find(:xpath, ".//td[4]")).to have_content("1")
  end

  def debe_mostrar_un_th_con_100
    expect(find("th", text: "$100.0")).to have_content("$100.0")
    expect(find("table.first").find(:xpath, ".//td[3]")).to have_content("5")
  end

  def debe_mostrar_un_th_con_10
    expect(find("th", text: "$10.0")).to have_content("$10.0")
    expect(find("table.first").find(:xpath, ".//td[2]")).to have_content("5")
  end

  def debe_mostrar_un_th_con_5
    expect(find("th", text: "$5.0")).to have_content("$5.0")
    expect(find("table.first").find(:xpath, ".//td[1]")).to have_content("10")
  end

  def debe_mostrar_un_total_de_800_en_monto_efectivo
    expect(first("tbody").find("span")).to have_content("$800.00")
  end


  def crea_arqueo_de_cheque_debito_credito
    emisor = create :emisor, :con_direccion
    recibo_cheque = create :recibo, :con_datos, cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil, forma_pago: "Cheque nominativo"
    recibo_debito = create :recibo, :con_datos, cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil, forma_pago: "Tarjeta de débito"
    recibo_credito = create :recibo, :con_datos, cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil, forma_pago: "Tarjeta de crédito"
    recibo_transferencia = create :recibo, :con_datos, cajero: @cajero, emisor: emisor,
      caja: @cajero.caja, arqueo: nil, forma_pago: "Transferencia electrónica de fondos"
    cierre_caja = create :cierre_caja, cajero: @cajero
    dinero = Dinero.new(total: 1600)
    arqueo = create :arqueo, monto_sistema: 1600, monto_cajero: 1600,
      cierre_caja: cierre_caja, dinero: dinero

    arqueo.recibos << [recibo_cheque, recibo_debito, recibo_credito, recibo_transferencia]
  end

  def debe_mostrar_un_texto_con_la_palabra_monto_no_efectivo
    expect(page).to have_content "Monto no efectivo"
  end

  def debe_mostrar_un_th_con_monto_cheque
    expect(find("th", text: "Monto Cheque")).to have_content("Monto Cheque")
    expect(find("table.second").find(:xpath, ".//td[1]")).to have_content("$400.00")
  end

  def debe_mostrar_un_th_con_monto_tarjeta_debito
    expect(find("th", text: "Monto Tarjeta Débito")).to have_content("Monto Tarjeta Débito")
    expect(find("table.second").find(:xpath, ".//td[2]")).to have_content("$400.00")
  end

  def debe_mostrar_un_th_con_monto_tarjeta_credito
    expect(find("th", text: "Monto Tarjeta Crédito")).to have_content("Monto Tarjeta Crédito")
    expect(find("table.second").find(:xpath, ".//td[3]")).to have_content("$400.00")
  end

  def debe_mostrar_un_th_con_monto_transferencia
    expect(find("th", text: "Monto Transferencia")).to have_content("Monto Transferencia")
    expect(find("table.second").find(:xpath, ".//td[4]")).to have_content("$400.00")
  end

  def debe_mostrar_un_subtotal_de_1600_en_monto_no_efectivo
    expect(find("table.second").find(:xpath, ".//td[5]")).to have_content("$1,600.00")
  end
end
