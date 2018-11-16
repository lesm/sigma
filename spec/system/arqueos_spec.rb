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

      cuando_cajero_agrega_una_moneda_de_10_una_moneda_de_20
      cuando_cajero_agrega_un_billete_de_100_un_billete_de_200
      monto_efectivo_debe_ser_330
      monto_total_debe_ser_730
      monto_adeudo_por_pagar_debe_ser_870
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
    expect(page).to have_content "$0.0"
  end

  def monto_banco_debe_ser_400
    expect(page).to have_content "Monto Banco"
    expect(page).to have_content "$400.0"
  end

  def monto_total_debe_ser_400
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$400.0"
  end

  def monto_adeudo_por_pagar_debe_ser_1600
    expect(page).to have_content "Adeudo por pagar"
    expect(page).to have_content "$1,600.00"
  end

  def cuando_cajero_agrega_una_moneda_de_10_una_moneda_de_20
    fill_in("$10.00", with: 1)
    find(:css, "input[id$='_veinte_m_pesos']").set(1)
  end

  def cuando_cajero_agrega_un_billete_de_100_un_billete_de_200
    fill_in("$100.00", with: 1)
    fill_in("$200.00", with: 1)
    fill_in "Observación", with: "Alguna observación"
  end

  def monto_efectivo_debe_ser_330
    expect(page).to have_content "Monto Efectivo"
    expect(page).to have_content "$330.0"
  end

  def monto_total_debe_ser_730
    expect(page).to have_content "Monto Total"
    expect(page).to have_content "$730.0"
  end

  def monto_adeudo_por_pagar_debe_ser_870
    expect(page).to have_content "Adeudo por pagar"
    expect(page).to have_content "$1,270.00"
  end

end
