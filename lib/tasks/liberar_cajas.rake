namespace :liberar_cajas do
  desc "Liberar cajas ocupadas."
  task ocupadas: :environment do
    LiberarCajas.new.call
  end

  class LiberarCajas
    def call
      Caja.no_disponibles.each do |caja|
        cajero = caja.cajero
        if cajero.arqueo_pendiente?
          crear_cierre_caja_con_arqueo(cajero)
        elsif cajero.cierre_caja_abierta?
          cerrar_cierre_caja(cajero)
        else
          crear_cierre_caja_con_arqueo_en_ceros(cajero)
        end
        caja.abrir!
        puts "Se libero la caja #{caja}"
      end
    end

    def crear_cierre_caja_con_arqueo cajero
      total  = cajero.monto_sistema
      arqueo = build_arqueo(total)
      create_cierre_caja(cajero: cajero, arqueo: arqueo, total: total)
      comprobantes = Comprobante.para_arqueo_actual(cajero)
      comprobantes.update_all(arqueo_id: arqueo.id)
    end

    def cerrar_cierre_caja cajero
      cajero.ultimo_cierre_caja.update_columns(abierta: false, automatico: true)
    end

    def crear_cierre_caja_con_arqueo_en_ceros cajero
      create_cierre_caja(cajero: cajero, arqueo: build_arqueo, total: 0)
    end

    private

    def build_arqueo total=0
      Arqueo.new(monto_sistema: total, monto_cajero: total)
    end

    def create_cierre_caja options
      cajero = options.fetch(:cajero)
      total  = options.fetch(:total)
      arqueo = options.fetch(:arqueo)
      CierreCaja.create(cajero: cajero, monto_sistema: total,
                        monto_cajero: total, abierta: false,
                        automatico: true, arqueos: [arqueo])
    end
  end
end
