if Rails.env.development?
  puts "Creando Emisor..."
  if Emisor.count.zero?
    emisor = Emisor.new(nombre: "Municipio de Huajuapan de León",
                        numero_municipio: "482", rfc: "AAAA111111AA",
                        regimen_fiscal: "Personas morales con fines no lucrativos",
                        registro_patronal: "sin registro",
                        logotipo: Rails.root.join('spec/fixtures/files/logotipo.png').open,
                        escudo:  Rails.root.join('spec/fixtures/files/escudo.png').open,
                        eslogan: "Por una mejor mixteca...")
    emisor.save!
  end

  Direccion.where(calle: "Independencia", numero: "8",
                   colonia: "Azteca", codigo_postal: "68000",
                   localidad: "Oaxaca", municipio: "Centro",
                   estado: "Oaxaca", pais: "México",
                   direccionable_type: "Emisor",
                   direccionable_id: Emisor.first.id).first_or_create!

  values = {
    nombre_o_razon_social: [
      "Carlos", "José", "Miguel",
      "Ruben", "Rodrigo", "Carla"
    ],
    primer_apellido: [
      "José", "Cruz", "Díaz",
      "Luis", "Ramos", "Sánchez"
    ],
    segundo_apellido: [
      "Pérez", "Hernández", "Cruz",
      "Santiago", "Candela", "Moreno"
    ],
    persona_fisica: true,
    email: [
      "carlos@mail.com", "jose@mail.com", "miguel@mail.com",
      "ruben@mail.com", "rodrigo@mail.com", "carla@mail.com"
    ],
    rfc: [
      "AAAA111111AAA", "AAAA111111AAB", "AAAA111111AAC",
      "AAAA111111AAD", "AAAA111111AAE", "AAAA111111AAF"
    ],
    concepto_ids: ["1","2"]
  }

  puts "Creando Contribuyentes..."
  if Contribuyente.count.zero?
    6.times do |n|
      Contribuyente.create!(
        nombre_o_razon_social: values[:nombre_o_razon_social][n],
        primer_apellido: values[:primer_apellido][n],
        segundo_apellido: values[:segundo_apellido][n],
        persona_fisica: values[:persona_fisica],
        email: values[:email][n],
        rfc: values[:rfc][n],
        concepto_ids: values[:concepto_ids]
      )
    end
  end

  puts "Creando Domicilios para contribuyentes..."
  Contribuyente.ids.each do |id|
    Direccion.where(calle: "Independencia", numero: "8",
                    colonia: "Azteca", codigo_postal: "68000",
                    localidad: "Oaxaca", municipio: "Centro",
                    estado: "Oaxaca", pais: "México",
                    direccionable_type: "Contribuyente",
                    direccionable_id: id).first_or_create!
  end

  puts "Creando a Super User"

  if Usuario.where(rol: 4).empty?
    Usuario.create!(nombre: "superuser", username: "superuser",
                    rol: 4, password: "1qaz2wsx")
  end

  puts "Creando Administrador..."
  if Administrador.count.zero?
    Administrador.create!(nombre: "admin", username: "admin",
                   rol: 3, password: "1qaz2wsx")
  end

  puts "Creando Cajero..."
  if Cajero.count.zero? and Contribuyente.first.id
    Cajero.create!(nombre: "cajero de prueba", username: "cajero",
                  password: "1qaz2wsx", rol: 1,
                  contribuyente_id: Contribuyente.first.id)
  end

  puts "Creando Caja..."
  Caja.where(nombre: "Principal",
             descripcion: "Se localiza en el municipio",
             numero: 1).first_or_create!
end

puts "Creando Cuentas..."
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110101", formato: "DatosComun", descripcion: "110101 - RIFAS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110102", formato: "DatosComun", descripcion: "110102 - SORTEOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110103", formato: "DatosComun", descripcion: "110103 - LOTERÍAS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110104", formato: "DatosComun", descripcion: "110104 - CONCURSOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110201", formato: "DatosComun", descripcion: "110201 -TEATROS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110202", formato: "DatosComun", descripcion: "110202 - CIRCOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110203", formato: "DatosComun", descripcion: "110203 - FERIAS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110204", formato: "DatosComun", descripcion: "110204 - BOX").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110205", formato: "DatosComun", descripcion: "110205 - LUCHA LIBRE").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110206", formato: "DatosComun", descripcion: "110206 - BAILES").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110207", formato: "DatosComun", descripcion: "110207 - PRESENTACIÓN DE ARTISTAS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110208", formato: "DatosComun", descripcion: "110208 - KERMÉS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110209", formato: "DatosComun", descripcion: "110209 - APARATOS MECÁNICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110210", formato: "DatosComun", descripcion: "110210 - APARATOS ELECTRÓNICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110211", formato: "DatosComun", descripcion: "110211 - APARATOS ELÉCTRICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110212", formato: "DatosComun", descripcion: "110212 - APARATOS ELECTROMECÁNICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "110213", formato: "DatosComun", descripcion: "110213 - MESAS DE JUEGO").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120101", formato: "DatosPredial", descripcion: "120101 - PREDIAL URBANOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120102", formato: "DatosPredial", descripcion: "120102 - PREDIAL RUSTICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120103", formato: "DatosPredial", descripcion: "120103 - PREDIAL EJIDALES").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120104", formato: "DatosPredial", descripcion: "120104 - PREDIAL COMUNALES").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120105", formato: "DatosPredialRezagos", descripcion: "120105 - PREDIAL REZAGOS").first_or_create

Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120201", formato: "DatosLicenciaFusion", descripcion: "120201 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN RESIDENCIAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120202", formato: "DatosLicenciaFusion", descripcion: "120202 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN TIPO MEDIO").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120203", formato: "DatosLicenciaFusion", descripcion: "120203 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN POPULAR").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120204", formato: "DatosLicenciaFusion", descripcion: "120204 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN DE INTERÉS SOCIAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120205", formato: "DatosLicenciaFusion", descripcion: "120205 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN CAMPESTRE").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120206", formato: "DatosLicenciaFusion", descripcion: "120206 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES GRANJA").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "120207", formato: "DatosLicenciaFusion", descripcion: "120207 - FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES INDUSTRIAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "130101", formato: "DatosTrasladoDominio", descripcion: "130101 - TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170101", formato: "DatosComun", descripcion: "170101 - MULTAS DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170201", formato: "DatosComun", descripcion: "170201 - MULTAS DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170202", formato: "DatosComun", descripcion: "170202 - MULTAS DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170203", formato: "DatosComun", descripcion: "170203 - MULTAS DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170204", formato: "DatosComun", descripcion: "170204 - MULTAS DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170205", formato: "DatosComun", descripcion: "170205 - MULTAS DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170301", formato: "DatosComun", descripcion: "170301 - RECARGOS DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170401", formato: "DatosComun", descripcion: "170401 - RECARGOS DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170402", formato: "DatosComun", descripcion: "170402 - RECARGOS DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170403", formato: "DatosComun", descripcion: "170403 - RECARGOS DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170404", formato: "DatosComun", descripcion: "170404 - RECARGOS DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170405", formato: "DatosComun", descripcion: "170405 - RECARGOS DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170501", formato: "DatosComun", descripcion: "170501 - GASTOS DE EJECUCIÓN DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170601", formato: "DatosComun", descripcion: "170601 - GASTOS DE EJECUCIÓN DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170602", formato: "DatosComun", descripcion: "170602 - GASTOS DE EJECUCIÓN DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170603", formato: "DatosComun", descripcion: "170603 - GASTOS DE EJECUCIÓN DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170604", formato: "DatosComun", descripcion: "170604 - GASTOS DE EJECUCIÓN DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "170605", formato: "DatosComun", descripcion: "170605 - GASTOS DE EJECUCIÓN DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310101", formato: "DatosComun", descripcion: "310101 - INTRODUCCIÓN DE AGUA POTABLE").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310102", formato: "DatosComun", descripcion: "310102 - INTRODUCCIÓN DE RED DE DRENAJE").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310103", formato: "DatosComun", descripcion: "310103 - ELECTRIFICACIÓN").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310104", formato: "DatosComun", descripcion: "310104 - REVESTIMIENTO DE CALLES M2").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310105", formato: "DatosComun", descripcion: "310105 - PAVIMENTACIÓN DE CALLES M2").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310106", formato: "DatosComun", descripcion: "310106 - BANQUETAS M2").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310107", formato: "DatosComun", descripcion: "310107 - GUARNICIONES METRO LINEAL").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310201", formato: "DatosComun", descripcion: "310201 - MULTAS DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310301", formato: "DatosComun", descripcion: "310301 - RECARGOS DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(clave_producto: "93161700 - Administración tributaria", clave_unidad: "E48 - Unidad de servicio", codigo: "310401", formato: "DatosComun", descripcion: "310401 - GASTOS DE EJECUCIÓN DE CONTRIBUCIONES DE MEJORAS").first_or_create

Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410101", formato: "DatosMercado", descripcion: "410101 - PUESTOS FIJOS EN MERCADOS CONSTRUIDOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410102", formato: "DatosMercado", descripcion: "410102 - PUESTOS SEMIFIJOS EN MERCADOS CONSTRUIDOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410103", formato: "DatosMercado", descripcion: "410103 - PUESTOS FIJOS EN PLAZAS, CALLES O TERRENOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410104", formato: "DatosMercado", descripcion: "410104 - PUESTOS SEMIFIJOS EN PLAZAS, CALLES O TERRENOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410105", formato: "DatosMercado", descripcion: "410105 - CASETAS O PUESTOS UBICADOS EN LA VÍA PÚBLICA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410106", formato: "DatosMercado", descripcion: "410106 - VENDEDORES AMBULANTES O ESPORÁDICOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410107", formato: "DatosMercado", descripcion: "410107 - OTORGAMIENTO, TRASPASO Y SUCESIÓN DE CONCESIÓN DE CASETA O PUESTO").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410109", formato: "DatosMercado", descripcion: "410109 - REGULARIZACIÓN DE CONCESIONES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410110", formato: "DatosMercado", descripcion: "410110 - AMPLIACIÓN O CAMBIO DE GIRO").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410111", formato: "DatosMercado", descripcion: "INSTALACIÓN DE CASETAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410112", formato: "DatosMercado", descripcion: "410112 - REAPERTURA DE PUESTO, LOCAL O CASETA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410114", formato: "DatosMercado", descripcion: "410114 - PERMISO PARA REMODELACIÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410116", formato: "DatosMercado", descripcion: "410116 - OTROS CONCEPTOS DE MERCADOS").first_or_create

Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410201", formato: "DatosComun", descripcion: "410201 - TRASLADO DE CADÁVERES FUERA DEL MUNICIPIO").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410205", formato: "DatosComun", descripcion: "410205 - CONSTRUCCIÓN DE MONUMENTOS, BÓVEDAS, MAUSOLEOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410206", formato: "DatosComun", descripcion: "410206 - INHUMACIÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410207", formato: "DatosComun", descripcion: "410207 - EXHUMACIÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410208", formato: "DatosComun", descripcion: "410208 - PERPETUIDAD").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410210", formato: "DatosComun", descripcion: "410210 - SERVICIOS DE REINHUMACIÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410211", formato: "DatosComun", descripcion: "410211 - DEPÓSITOS DE RESTOS EN NICHOS O GAVETAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410212", formato: "DatosComun", descripcion: "410212 - CONSTRUCCIÓN, RECONSTRUCCIÓN O PROFUNDIZACIÓN DE FOSAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410213", formato: "DatosComun", descripcion: "410213 - CONSTRUCCIÓN O REPARACIÓN DE MONUMENTOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410214", formato: "DatosComun", descripcion: "410214 - MANTENIMIENTO DE PASILLOS, ANDENES Y SERVICIOS GENERALES DE LOS PANTEONES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410215", formato: "DatosComun", descripcion: "410215 - CERTIFICADOS POR EXPEDICIÓN DE ANTECEDENTES DE TÍTULO O CAMBIO DE TITULAR").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410220", formato: "DatosComun", descripcion: "410220 - DESMONTE Y MONTE DE MONUMENTOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410221", formato: "DatosComun", descripcion: "410221 - OTROS CONCEPTOS DE PANTEONES").first_or_create

#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410301", descripcion: "410301 - TRASLADO DE GANADO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410302", descripcion: "410302 - USO DE CORRAL").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410306", descripcion: "410306 - MATANZA DE GANADO VACUNO POR CABEZA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410307", descripcion: "410307 - MATANZA DE GANADO PORCINO POR CABEZA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410308", descripcion: "410308 - MATANZA DE GANADO OVINO POR CABEZA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410309", descripcion: "410309 - MATANZA DE GANADO LANAR O CABRÍO POR CABEZA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410311", descripcion: "410311 - MATANZA DE OTROS ANIMALES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410312", descripcion: "410312 - REGISTRO DE FIERROS, MARCAS, ARETES Y SEÑALES DE SANGRE").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410313", descripcion: "410313 - REFRENDO DE FIERROS, MARCAS, ARETES Y SEÑALES DE SANGRE").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "410314", descripcion: "410314 - OTROS CONCEPTOS DE RASTRO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430101", descripcion: "430101 - ALUMBRADO PÚBLICO").first_or_create

Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430201", formato: "DatosBasura", descripcion: "430201 - RECOLECCIÓN DE BASURA EN ÁREA COMERCIAL").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430202", formato: "DatosBasura", descripcion: "430202 - RECOLECCIÓN DE BASURA EN ÁREA INDUSTRIAL").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430203", formato: "DatosBasura", descripcion: "430203 - RECOLECCIÓN DE BASURA EN CASA-HABITACIÓN").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430206", descripcion: "430206 - OTROS CONCEPTOS DE ASEO PÚBLICO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430401", descripcion: "430401 - COPIAS DE DOCUMENTOS EXISTENTES EN LOS ARCHIVOS MUNICIPALES POR HOJA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430402", formato: "DatosCertificacion", descripcion: "430402 - EXPEDICIÓN DE CERTIFICADOS DE RESIDENCIA, ORIGEN, DEPENDENCIA ECONÓMICA, DE SITUACIÓN FISCAL, DE CONTRIBUYENTES INSCRITOS EN LA TESORERÍA MUNICIPAL Y DE MORADA CONYUGAL").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430403", formato: "DatosCertificacion", descripcion: "430403 - CERTIFICACIÓN DE REGISTRO FISCAL DE BIENES INMUEBLES EN EL PADRÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430404", formato: "DatosCertificacion", descripcion: "430404 - CERTIFICACIÓN DE LA SUPERFICIE DE UN PREDIO").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430405", formato: "DatosCertificacion", descripcion: "430405 - CERTIFICACIÓN DE LA UBICACIÓN DE UN INMUEBLE").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430406", formato: "DatosCertificacion", descripcion: "430406 - BÚSQUEDA DE DOCUMENTOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430407", formato: "DatosCertificacion", descripcion: "430407 - CONSTANCIAS Y COPIAS CERTIFICADAS DISTINTAS A LAS ANTERIORES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430408", formato: "DatosCertificacion", descripcion: "430408 - OTROS CONCEPTOS DE CERTIFICACIONES, CONSTANCIAS Y LEGALIZACIONES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430501", formato: "DatosLicenciaConstruccion", descripcion: "430501 - PERMISOS DE CONSTRUCCIÓN, RECONSTRUCCIÓN Y AMPLIACIÓN DE INMUEBLES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430502", formato: "DatosLicenciaConstruccion", descripcion: "430502 - REMODELACIÓN DE BARDAS Y FACHADAS DE FINCAS URBANAS Y RÚSTICAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430503", formato: "DatosLicenciaConstruccion", descripcion: "430503 - DEMOLICIÓN DE CONSTRUCCIONES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430504", formato: "DatosLicenciaPredio", descripcion: "430504 - ASIGNACIÓN DE NÚMERO OFICIAL A PREDIOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430505", descripcion: "430505 - ALINEACIÓN Y USO DE SUELO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430506", descripcion: "430506 - RENOVACIÓN DE LICENCIAS DE CONSTRUCCIÓN").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430507", descripcion: "430507 - RETIRO DE SELLO DE OBRA SUSPENDIDA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430508", descripcion: "430508 - REGULARIZACIÓN DE CONSTRUCCIÓN DE CASA HABITACIÓN, COMERCIAL E INDUSTRIAL").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430510", descripcion: "430510 - PERMISOS PARA FRACCIONAMIENTO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430511", descripcion: "430511 - CONSTITUCIÓN DEL RÉGIMEN EN CONDOMINIO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430512", descripcion: "430512 - APROBACIÓN Y REVISIÓN DE PLANOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430513", descripcion: "430513 - OTROS CONCEPTOS DE PERMISOS EN MATERIA DE CONSTRUCCIÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430601", formato: "DatosLicenciaComercial", descripcion: "430601 - LICENCIAS Y REFRENDOS COMERCIAL").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430602", formato: "DatosLicenciaComercial", descripcion: "430602 - LICENCIAS Y REFRENDOS INDUSTRIAL").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430603", formato: "DatosLicenciaComercial", descripcion: "430603 - LICENCIAS Y REFRENDOS SERVICIOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430701", formato: "DatosLicenciaComercial", descripcion: "430701 - LICENCIAS, PERMISOS O AUTORIZACIONES POR COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS EN ENVASES CERRADOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430702", formato: "DatosLicenciaComercial", descripcion: "430702 - LICENCIAS, PERMISOS O AUTORIZACIONES POR COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS EN ENVASES ABIERTOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430703", formato: "DatosLicenciaComercial", descripcion: "430703 - LICENCIAS, PERMISOS O AUTORIZACIONES POR VENTA AL COPEO DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430704", formato: "DatosLicenciaComercial", descripcion: "430704 - PERMISOS TEMPORALES DE COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430705", formato: "DatosLicenciaComercial", descripcion: "430705 - LICENCIAS, PERMISOS O AUTORIZACIONES POR FUNCIONAMIENTO EN HORARIO EXTRAORDINARIO DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430706", formato: "DatosLicenciaComercial", descripcion: "430706 - REVALIDACIÓN ANUAL DE LICENCIAS DE FUNCIONAMIENTO, DISTRIBUCIÓN Y COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430707", formato: "DatosLicenciaComercial", descripcion: "430707 - AUTORIZACIÓN DE MODIFICACIONES A LAS LICENCIAS PARA EL FUNCIONAMIENTO, DISTRIBUCIÓN Y COMERCIALIZACIÓN").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430708", formato: "DatosLicenciaComercial", descripcion: "430708 - OTROS CONCEPTOS DE LICENCIAS Y REFRENDOS DE FUNCIONAMIENTO COMERCIAL, INDUSTRIAL Y DE SERVICIOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430801", formato: "DatosPermisoPublicidad", descripcion: "430801 - PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE PARED, ADOSADOS O AZOTEAS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430802", formato: "DatosPermisoPublicidad", descripcion: "430802 - PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE PINTADO O INTEGRADO EN ESCAPARATE O TOLDO").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430803", formato: "DatosPermisoPublicidad", descripcion: "430803 - PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE ANUNCIOS COLOCADOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430804", formato: "DatosPermisoPublicidad", descripcion: "430804 - PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE DIFUSIÓN FONÉTICA DE PUBLICIDAD POR UNIDAD DE SONIDO").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430806", formato: "DatosPermisoPublicidad", descripcion: "430806 - PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE CARTELERAS DE CINES, CIRCOS, TEATROS, OTROS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "430913", descripcion: "430913 - OTROS CONCEPTOS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431001", descripcion: "431001 - CONSULTA MÉDICA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431003", descripcion: "431003 - SERVICIOS PRESTADOS PARA EL CONTROL DE ENFERMEDADES DE TRANSMISIÓN SEXUAL").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431005", descripcion: "431005 - CONSULTA DE ODONTOLOGÍA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431007", descripcion: "431007 - SESIÓN DE TERAPIAS FÍSICAS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431011", descripcion: "431011 - OTROS SERVICIOS PRESTADOS EN MATERIA DE SALUD Y CONTROL DE ENFERMEDADES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431101", descripcion: "431101 - SANITARIO PÚBLICO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431401", descripcion: "431401 - SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA ELEMENTO CONTRATADO POR 12 HRS.").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431402", descripcion: "431402 - SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA ELEMENTO CONTRATADO POR 24 HRS.").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431403", descripcion: "431403 - OTROS SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431501", formato: "DatosPermisoCarga", descripcion: "431501 - PERMISO PROVISIONAL PARA CARGA Y DESCARGA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431502", formato: "DatosMultaTransito", descripcion: "431502 - SERVICIOS DE ARRASTRE EN GRUA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431505", descripcion: "431505 - SERVICIOS ESPECIALES PATRULLA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431506", descripcion: "431506 - SERVICIOS ESPECIALES ELEMENTO PEDESTRE").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431507", descripcion: "431507 - SERVICIOS ESPECIALES OTROS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431701", descripcion: "431701 - ESTACIONAMIENTO PERMANENTE").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431702", descripcion: "431702 - ESTACIONAMIENTO DE VEHICULOS DE  ALQUILER O DE CARGA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431706", descripcion: "431706 - OCUPACION DE LA VIA PUBLICA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431901", formato: "DatosPadronContratista", descripcion: "431901 - INSCRIPCION  AL PADRON DE CONTRATISTAS DE OBRA PUBLICA").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "431902", formato: "DatosCincoMillar", descripcion: "431902 - CONTRATOS  DE OBRA PÚBLICA Y SERVICIOS 5 AL MILLAR").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "450101", descripcion: "450101 - MULTAS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "450102", descripcion: "450102 - MULTAS DE OTROS DERECHOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "450201", descripcion: "450201 - RECARGOS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "450202", descripcion: "450202 - RECARGOS DE OTROS DERECHOS").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "450301", formato: "DatosAgua", descripcion: "450301 - GASTOS DE EJECUCIÓN DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "450302", descripcion: "450302 - GASTOS DE EJECUCIÓN DE OTROS DERECHOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510103", descripcion: "510103 - DERIVADO DE  ARRENDAMIENTO DE OTROS BIENES INMUEBLES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510201", descripcion: "510201 - DERIVADO DE ARRENDAMIENTO DE MAQUINARIA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510403", descripcion: "510403 - BASES PARA LICITACIÓN PÚBLICA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510404", descripcion: "510404 - BASES PARA INVITACIÓN RESTRINGIDA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510501", descripcion: "510501 - PRODUCTOS FINANCIEROS DEL RAMO 28 CHEQUES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510601", descripcion: "510601 - PRODUCTOS FINANCIEROS DEL FONDO III CHEQUES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "510701", descripcion: "510701 - PRODUCTOS FINANCIEROS DEL FONDO IV CHEQUES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "520201", descripcion: "520201 - ENAJENACION DE BIENES MUEBLES E INTANGIBLES").first_or_create
Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610101", formato: "DatosMultaAdministrativa", descripcion: "610101 - MULTAS ADMINISTRATIVAS IMPUESTAS POR EL MUNICIPIO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610102", descripcion: "610102 - OTRAS MULTAS NO DESCRITAS ANTERIORMENTE").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610301", descripcion: "610301 - REINTEGRO POR RESPONSABILIDAD DE REVISIÓN DE CUENTA PÚBLICA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610302", descripcion: "610302 - REINTEGRO POR RECUPERACIÓN DE OBRA PÚBLICA").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610303", descripcion: "610303 - RECUPERACIÓN DE FIANZAS DE CUMPLIMIENTO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610304", descripcion: "610304 - RECUPERACIÓN DE FIANZAS DE ANTICIPO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610305", descripcion: "610305 - RECUPERACIÓN DE FIANZAS DE VICIOS OCULTOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610501", descripcion: "610501 - APORTACION DE BENEFICIARIOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610601", descripcion: "610601 - MULTAS DE APROVECHAMIENTOS POR PAGO EXTEMPORÁNEO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610602", descripcion: "610602 - RECARGOS DE APROVECHAMIENTOS POR INCUMPLIMIENTO DE CRÉDITOS FISCALES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610603", descripcion: "610603 - GASTOS DE EJECUCION DE APROVECHAMIENTOS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610702", descripcion: "610702 - DONATIVOS EN EFECTIVO").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "610703", descripcion: "610703 - DONACIONES DE MATERIALES Y SUMINISTROS").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "620103", descripcion: "620103 - DONACIONES RECIBIDAS DE OTROS BIENES INMUEBLES").first_or_create
#Cuenta.where(clave_producto: "93171500 - Política comercial", clave_unidad: "E48 - Unidad de servicio", codigo: "620201", descripcion: "620201 - DONACIONES RECIBIDAS DE BIENES MUEBLES E INTANGIBLES").first_or_create


#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "810101", descripcion: "810101 - FONDO DE PARTICIPACIONES").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "810201", descripcion: "810201 - FONDO DE FOMENTO").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "810301", descripcion: "810301 - FONDO DE COMPENSACIONES").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "810401", descripcion: "810401 - FOGADI").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "810701", descripcion: "810701 - ISR SALARIOS").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "820101", descripcion: "820101 - FISMDF").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "820201", descripcion: "820201 - FORTAMUN").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "830103", descripcion: "830103 - CONVENIOS FEDERALES PETROLEOS MEXICANOS").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "830244", descripcion: "830244 - SECRETARÍA DE DESARROLLO AGRARIO, TERRITORIAL Y URBANO (SEDATU)").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "830301", descripcion: "830301 - PROGRAMAS ESTATALES PROGRAMA").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "830401", descripcion: "830401 - CONVENIOS PARTICULARES PERSONA MORAL").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "830402", descripcion: "830402 - CONVENIOS PARTICULARES PERSONA FÍSICA").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "940101", descripcion: "940101 - BECAS").first_or_create
#Cuenta.where(clave_producto: "93151500 - Administración pública", clave_unidad: "E48 - Unidad de servicio", codigo: "010101", descripcion: "010101 - EMPRESTITOS BANOBRAS").first_or_create

##Cuenta.first_or_initialize(codigo: "6107005", descripcion: "6107005 - DERECHOS POR OTORGAMIENTO DE LA COMISION Y POR ELUSO O GOSE DE LA ZOFEMAT").first_or_create
