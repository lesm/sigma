require 'rails_helper'

RSpec.describe "Cajero creating a global invoice", type: :system do
  feature "Factura Global" do
    before :each do
      dado_que_hay_un_recibo_sin_factura_global
      dado_que_hay_un_cajero_logueado_con_una_caja
      cajero_da_click_en_link_recaudacion
    end

    scenario "generates new factura global" do
      cajero_da_click_en_link_factura_global
      cajero_da_click_en_link_agregar_factura_global
      cajero_selecciona_fecha_inicio
      cajero_selecciona_fecha_fin
      cuando_cajero_da_click_en_el_boton_buscar
      cajero_es_redireccionado_a_new_factura_global_path
      cajero_debe_ver_el_total_de_la_factura_global
      dado_que_cajero_captura_datos_para_factura_global
      cuando_cajero_da_click_en_boton_crear_factura_global
      cajero_debe_ver_factura_global_creada_correctamente
      cajero_debe_ver_datos_de_factura_global
    end

    def dado_que_hay_un_recibo_sin_factura_global
      @contribuyente = create :contribuyente, :con_direccion,
        nombre_o_razon_social: "Carlos José", primer_apellido: "Pérez",
        rfc: "AAAA111111AAZ"
      @recibo = create :recibo, :para_timbrar, contribuyente: @contribuyente,
        factura_global_id: nil
    end

    def cajero_da_click_en_link_factura_global
      click_link "Facturas globales"
    end

    def cajero_da_click_en_link_agregar_factura_global
      click_link "Agregar Factura Global"
      expect(page).to have_content "Seleccionar periodo de la factura global"
    end

    def cajero_selecciona_fecha_inicio
      page.find('#factura_global_fecha_inicio').set("#{Date.current.beginning_of_day.to_date.to_s}")
    end

    def cajero_selecciona_fecha_fin
      page.find('#factura_global_fecha_fin').set("#{Date.current.end_of_day.to_date.to_s}")
    end

    def cuando_cajero_da_click_en_el_boton_buscar
      click_button "Buscar"
    end

    def cajero_es_redireccionado_a_new_factura_global_path
      expect(page).to have_current_path(/factura_globales\/new/)
      expect(page).to have_content "Generar Factura Global"
    end

    def cajero_debe_ver_el_total_de_la_factura_global
      expect(find_field("Total").value).to eq "400.0"
    end

    def dado_que_cajero_captura_datos_para_factura_global
      select "Carlos José Pérez", from: "Contribuyente "
      select "01 - Efectivo", from: "Forma de Pago"
      select "G03 - Gastos en general", from: "Uso cfdi"
    end

    def cuando_cajero_da_click_en_boton_crear_factura_global
      click_button "Crear Factura global"
    end

    def cajero_debe_ver_factura_global_creada_correctamente
      expect(page).to have_content "Factura global fue creada correctamente."
    end

    def cajero_debe_ver_datos_de_factura_global
      expect(page).to have_content "Detalle Factura Global"
      expect(page).to have_content "110101 - RIFAS"
      expect(page).to have_content "110102 - SORTEOS"
    end
  end
end
