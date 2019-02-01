namespace :close do
  desc "Procesar comprobantes sin cierre de caja"
  task cajas: :environment do
    cajas = Caja.no_disponibles
    if cajas
      cajas.each do |caja|
        arqueo = Arqueo.new(
          dinero: Dinero.new,
          monto_sistema: caja.comprobantes.total_monto_sistema(caja.cajero),
          monto_cajero: caja.comprobantes.total_monto_sistema(caja.cajero)
        )
        cierre_caja = CierreCaja.create(
          cajero: caja.cajero,
          monto_sistema: caja.comprobantes.total_monto_sistema(caja.cajero),
          monto_cajero: caja.comprobantes.total_monto_sistema(caja.cajero),
          abierta: false
        )

        caja.abrir!
        cierre_caja.arqueos << arqueo
        caja.comprobantes.update_all(arqueo_id: arqueo.id)
        puts "#{Time.current} | Para el cajero #{caja.cajero} en la caja #{caja}, se género el arqueo con folio #{arqueo.id}, cierre de caja folio #{cierre_caja.id} y monto $#{arqueo.monto_sistema}."
      end
    else
      puts "#{Time.current} | No existen comprobantes para procesar."
    end
  end
end
