namespace :liberar_cajas do
  desc "Liberar cajas ocupadas."
  task ocupadas: :environment do
    LiberarCajas.new.call
  end

  class LiberarCajas
    def call
      cajas_ocupadas.each do |caja|
        if caja.comprobantes.sin_arqueo.any?
          cajero       = caja.cajero
          comprobantes = caja.comprobantes.para_arqueo_actual cajero
          total        = comprobantes.total_monto_sistema cajero

          arqueo = crear_arqueo total
          crear_cierre_caja cajero, arqueo, total
          comprobantes.update_all(arqueo_id: arqueo.id)

          caja.abrir!
        elsif caja.cajero.cierre_cajas.abiertas.any?
          caja.cajero.cierre_cajas.abiertas.update_all(abierta: false)

          caja.abrir!
        else ! caja.disponible
          cajero = caja.cajero
          arqueo = crear_arqueo
          crear_cierre_caja cajero, arqueo

          caja.abrir!
        end
      end
    end

    def cajas_ocupadas
      Caja.no_disponibles
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
  end
end
