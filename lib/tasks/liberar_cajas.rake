namespace :liberar_cajas do
  desc "Verifica que las cajas esten disponibles"
  task no_disponibles: :environment do
    LiberarCajas.new.call
    #TODO Abrir las cajas no disponibles
  end

  class LiberarCajas
    def call
      if cajas_no_disponibles_y_comprobantes_sin_arqueo?
        crear_arqueo_con_cierre_de_caja
      elsif cajas_no_disponibles_y_cierre_cajas_abiertas?
        cerrar_cierre_cajas
      elsif cajas_no_disponibles?
        crear_arqueo_con_cierre_de_caja_en_ceros
      end
    end

    private

    def cajas_no_disponibles_y_comprobantes_sin_arqueo?
      cajas_no_disponibles? && comprobantes_sin_arqueo?
    end

    def cajas_no_disponibles_y_cierre_cajas_abiertas?
      cajas_no_disponibles? && cierre_cajas_abiertas?
    end

    def cajas_no_disponibles?
      cajas_no_disponibles.count > 0
    end

    def comprobantes_sin_arqueo?
      cajas_no_disponibles.each do |caja|
        return true if caja.comprobantes.sin_arqueo.count > 0
      end
      false
    end

    def cierre_cajas_abiertas?
      cierre_cajas_abiertas.count > 0
    end

    def cajas_no_disponibles
      Caja.no_disponibles
    end

    def cierre_cajas_abiertas
      CierreCaja.abiertas
    end

    def crear_arqueo_con_cierre_de_caja
      cajas_no_disponibles.each do |caja|
        cajero       = caja.cajero
        comprobantes = caja.comprobantes.para_arqueo_actual cajero
        total        = comprobantes.total_monto_sistema cajero

        arqueo = crear_arqueo total
        crear_cierre_caja cajero, arqueo, total
        comprobantes.update_all(arqueo_id: arqueo.id)

        caja.abrir!
      end
      puts "Cierre automatico, se genero arqueo y cierre caja."
    end

    def crear_arqueo(total = 0)
      Arqueo.new(dinero: Dinero.new, monto_sistema: total,
                monto_cajero: total)
    end

    def crear_cierre_caja(cajero, arqueo, total = 0)
      cierre_caja = CierreCaja.create(
        cajero: cajero, monto_sistema: total,
        monto_cajero: total, abierta: false)

      cierre_caja.arqueos << arqueo
    end

    def cerrar_cierre_cajas
      cierre_cajas_abiertas.each do |cierre_caja|
        cierre_caja.update_column(:abierta, false)
        #TODO caja
        # como si no encontrara la caja
        # pero con puts si imprime el id
        #cierre_caja.cajero.caja.abrir!
      end
      puts "Cierre automatico, se cerro el cierre caja."
    end

    def crear_arqueo_con_cierre_de_caja_en_ceros
      cajas_no_disponibles.each do |caja|
        cajero = caja.cajero

        arqueo = crear_arqueo
        crear_cierre_caja cajero, arqueo
        caja.abrir!
      end
      puts "Liberar caja, con arqueo y cierre caja en 0."
    end
  end
end
