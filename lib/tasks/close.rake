namespace :close do
  desc "Verifica que las cajas esten disponibles"
  task cajas: :environment do
    CloseCajas.call
    #TODO Abrir las cajas no disponibles
  end

  class CloseCajas
    def self.call
      if cajas_no_disponibles_y_comprobantes_sin_arqueo?
        crear_arqueo_con_cierre_de_caja
        puts "Cierre automatico, se genero arqueo y cierre caja."
      elsif cajas_no_disponibles_y_cierre_cajas_abiertas?
        cerrar_cierre_cajas
        puts "Cierre automatico, se cerro el cierre caja."
      end
    end

    private

    def self.cajas_no_disponibles_y_comprobantes_sin_arqueo?
      cajas_no_disponibles? && comprobantes_sin_arqueo?
    end

    def self.cajas_no_disponibles_y_cierre_cajas_abiertas?
      cajas_no_disponibles? && cierre_cajas_abiertas?
    end

    def self.cajas_no_disponibles?
      cajas_no_disponibles.count > 0
    end

    def self.comprobantes_sin_arqueo?
      cajas_no_disponibles.each do |caja|
        return true if caja.comprobantes.count > 0
      end
      false
    end

    def self.cierre_cajas_abiertas?
      cierre_cajas_abiertas.count > 0
    end

    def self.cajas_no_disponibles
      Caja.no_disponibles
    end

    def self.cierre_cajas_abiertas
      CierreCaja.abiertas
    end

    def self.crear_arqueo_con_cierre_de_caja
      cajas_no_disponibles.each do |caja|
        comprobantes = caja.comprobantes
        cajero       = caja.cajero
        total        = comprobantes.total_monto_sistema(cajero)

        arqueo = crear_arqueo total
        crear_cierre_caja cajero, total, arqueo
        comprobantes.update_all(arqueo_id: arqueo.id)
      end
    end

    def self.crear_arqueo total
      Arqueo.new(dinero: Dinero.new, monto_sistema: total,
                monto_cajero: total)
    end

    def self.crear_cierre_caja cajero, total, arqueo
      cierre_caja = CierreCaja.create(
        cajero: cajero, monto_sistema: total,
        monto_cajero: total, abierta: false)

      cierre_caja.arqueos << arqueo
    end

    def self.cerrar_cierre_cajas
      cierre_cajas_abiertas.each do |cierre_caja|
        cierre_caja.update_column(:abierta, false)
      end
    end
  end
end
