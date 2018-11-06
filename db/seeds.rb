puts "Creando Emisor..."
Emisor.where(nombre: "Municipio de Huajuapan de León", rfc: "AAAA111111AA", regimen_fiscal: "Personas morales con fines no lucrativos", registro_patronal: "sin registro", eslogan: "Por una mejor mixteca...").first_or_create
Direccion.where(calle: "Independencia", numero: "8", colonia: "Azteca", codigo_postal: "68000", localidad: "Oaxaca", municipio: "Centro", estado: "Oaxaca", pais: "México", direccionable_type: "Emisor", direccionable_id: Emisor.first.id).first_or_create

puts "Creando Contribuyentes..."
Contribuyente.where(nombre_o_razon_social: "Carlos", primer_apellido: "José", segundo_apellido: "Pérez", persona_fisica: true, email: "jose@mail.com", rfc: "AAAA111111AAA").first_or_create
Contribuyente.where(nombre_o_razon_social: "Jose", primer_apellido: "Cruz", segundo_apellido: "Hernández", persona_fisica: true, email: "carlos@mail.com", rfc: "AAAA111111AAB").first_or_create
Contribuyente.where(nombre_o_razon_social: "Miguel", primer_apellido: "Díaz", segundo_apellido: "Cruz", persona_fisica: true, email: "miguel@mail.com", rfc: "AAAA111111AAC").first_or_create
Contribuyente.where(nombre_o_razon_social: "Ruben", primer_apellido: "Luis", segundo_apellido: "Santiago", persona_fisica: true, email: "ruben@mail.com", rfc: "AAAA111111AAD").first_or_create
Contribuyente.where(nombre_o_razon_social: "Rodrigo", primer_apellido: "Bautista", segundo_apellido: "Nose", persona_fisica: true, email: "rodrigo@mail.com", rfc: "AAAA111111AAE").first_or_create
Contribuyente.where(nombre_o_razon_social: "andrea", primer_apellido: "Jeronimo", segundo_apellido: "Nose", persona_fisica: true, email: "andrea@mail.com", rfc: "AAAA111111AAF").first_or_create

puts "Creando Contribuyentes..."
Contribuyente.ids.each do |id|
  Direccion.where(calle: "Independencia", numero: "8", colonia: "Azteca", codigo_postal: "68000", localidad: "Oaxaca", municipio: "Centro", estado: "Oaxaca", pais: "México", direccionable_type: "Contribuyente", direccionable_id: id).first_or_create
end


puts "Creando Cajero..."
Cajero.create(nombre: "cajero de prueba", username: "cajero", password: "1qaz2wsx", rol: 1, contribuyente_id: Contribuyente.first.id) rescue nil

puts "Creando Caja..."
Caja.where(nombre: "Principal", descripcion: "Se localiza en el municipio").first_or_create

puts "Creando Cuentas..."
Cuenta.where(codigo: "110101", formato: "DatosComun", descripcion: "RIFAS").first_or_create
Cuenta.where(codigo: "110102", formato: "DatosComun", descripcion: "SORTEOS").first_or_create
Cuenta.where(codigo: "110103", formato: "DatosComun", descripcion: "LOTERÍAS").first_or_create
Cuenta.where(codigo: "110104", formato: "DatosComun", descripcion: "CONCURSOS").first_or_create
Cuenta.where(codigo: "110201", formato: "DatosComun", descripcion: "TEATROS").first_or_create
Cuenta.where(codigo: "110202", formato: "DatosComun", descripcion: "CIRCOS").first_or_create
Cuenta.where(codigo: "110203", formato: "DatosComun", descripcion: "FERIAS").first_or_create
Cuenta.where(codigo: "110204", formato: "DatosComun", descripcion: "BOX").first_or_create
Cuenta.where(codigo: "110205", formato: "DatosComun", descripcion: "LUCHA LIBRE").first_or_create
Cuenta.where(codigo: "110206", formato: "DatosComun", descripcion: "BAILES").first_or_create
Cuenta.where(codigo: "110207", formato: "DatosComun", descripcion: "PRESENTACIÓN DE ARTISTAS").first_or_create
Cuenta.where(codigo: "110208", formato: "DatosComun", descripcion: "KERMÉS").first_or_create
Cuenta.where(codigo: "110209", formato: "DatosComun", descripcion: "APARATOS MECÁNICOS").first_or_create
Cuenta.where(codigo: "110210", formato: "DatosComun", descripcion: "APARATOS ELECTRÓNICOS").first_or_create
Cuenta.where(codigo: "110211", formato: "DatosComun", descripcion: "APARATOS ELÉCTRICOS").first_or_create
Cuenta.where(codigo: "110212", formato: "DatosComun", descripcion: "APARATOS ELECTROMECÁNICOS").first_or_create
Cuenta.where(codigo: "110213", formato: "DatosComun", descripcion: "MESAS DE JUEGO").first_or_create
Cuenta.where(codigo: "120101", formato: "DatosPredial", descripcion: "PREDIAL URBANOS").first_or_create
Cuenta.where(codigo: "120102", formato: "DatosPredial", descripcion: "PREDIAL RUSTICOS").first_or_create
Cuenta.where(codigo: "120103", formato: "DatosPredial", descripcion: "PREDIAL EJIDALES").first_or_create
Cuenta.where(codigo: "120104", formato: "DatosPredial", descripcion: "PREDIAL COMUNALES").first_or_create
Cuenta.where(codigo: "120105", formato: "DatosPredial", descripcion: "PREDIAL REZAGOS").first_or_create

Cuenta.where(codigo: "120201", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN RESIDENCIAL").first_or_create
Cuenta.where(codigo: "120202", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN TIPO MEDIO").first_or_create
Cuenta.where(codigo: "120203", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN POPULAR").first_or_create
Cuenta.where(codigo: "120204", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN DE INTERÉS SOCIAL").first_or_create
Cuenta.where(codigo: "120205", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN CAMPESTRE").first_or_create
Cuenta.where(codigo: "120206", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES GRANJA").first_or_create
Cuenta.where(codigo: "120207", formato: "DatosLicenciaFusion", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES INDUSTRIAL").first_or_create
Cuenta.where(codigo: "130101", formato: "DatosTrasladoDominio", descripcion: "TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "170101", formato: "DatosComun", descripcion: "MULTAS DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(codigo: "170201", formato: "DatosComun", descripcion: "MULTAS DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(codigo: "170202", formato: "DatosComun", descripcion: "MULTAS DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(codigo: "170203", formato: "DatosComun", descripcion: "MULTAS DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(codigo: "170204", formato: "DatosComun", descripcion: "MULTAS DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "170205", formato: "DatosComun", descripcion: "MULTAS DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "170301", formato: "DatosComun", descripcion: "RECARGOS DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(codigo: "170401", formato: "DatosComun", descripcion: "RECARGOS DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(codigo: "170402", formato: "DatosComun", descripcion: "RECARGOS DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(codigo: "170403", formato: "DatosComun", descripcion: "RECARGOS DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(codigo: "170404", formato: "DatosComun", descripcion: "RECARGOS DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "170405", formato: "DatosComun", descripcion: "RECARGOS DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "170501", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(codigo: "170601", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(codigo: "170602", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(codigo: "170603", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(codigo: "170604", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "170605", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "310101", formato: "DatosComun", descripcion: "INTRODUCCIÓN DE AGUA POTABLE").first_or_create
Cuenta.where(codigo: "310102", formato: "DatosComun", descripcion: "INTRODUCCIÓN DE RED DE DRENAJE").first_or_create
Cuenta.where(codigo: "310103", formato: "DatosComun", descripcion: "ELECTRIFICACIÓN").first_or_create
Cuenta.where(codigo: "310104", formato: "DatosComun", descripcion: "REVESTIMIENTO DE CALLES M2").first_or_create
Cuenta.where(codigo: "310105", formato: "DatosComun", descripcion: "PAVIMENTACIÓN DE CALLES M2").first_or_create
Cuenta.where(codigo: "310106", formato: "DatosComun", descripcion: "BANQUETAS M2").first_or_create
Cuenta.where(codigo: "310107", formato: "DatosComun", descripcion: "GUARNICIONES METRO LINEAL").first_or_create
Cuenta.where(codigo: "310201", formato: "DatosComun", descripcion: "MULTAS DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(codigo: "310301", formato: "DatosComun", descripcion: "RECARGOS DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(codigo: "310401", formato: "DatosComun", descripcion: "GASTOS DE EJECUCIÓN DE CONTRIBUCIONES DE MEJORAS").first_or_create

Cuenta.where(codigo: "410101", formato: "DatosMercado", descripcion: "PUESTOS FIJOS EN MERCADOS CONSTRUIDOS").first_or_create
Cuenta.where(codigo: "410102", formato: "DatosMercado", descripcion: "PUESTOS SEMIFIJOS EN MERCADOS CONSTRUIDOS").first_or_create
Cuenta.where(codigo: "410103", formato: "DatosMercado", descripcion: "PUESTOS FIJOS EN PLAZAS, CALLES O TERRENOS").first_or_create
Cuenta.where(codigo: "410104", formato: "DatosMercado", descripcion: "PUESTOS SEMIFIJOS EN PLAZAS, CALLES O TERRENOS").first_or_create
Cuenta.where(codigo: "410105", formato: "DatosMercado", descripcion: "CASETAS O PUESTOS UBICADOS EN LA VÍA PÚBLICA").first_or_create
Cuenta.where(codigo: "410106", formato: "DatosMercado", descripcion: "VENDEDORES AMBULANTES O ESPORÁDICOS").first_or_create
Cuenta.where(codigo: "410107", formato: "DatosMercado", descripcion: "OTORGAMIENTO, TRASPASO Y SUCESIÓN DE CONCESIÓN DE CASETA O PUESTO").first_or_create
Cuenta.where(codigo: "410109", formato: "DatosMercado", descripcion: "REGULARIZACIÓN DE CONCESIONES").first_or_create
Cuenta.where(codigo: "410110", formato: "DatosMercado", descripcion: "AMPLIACIÓN O CAMBIO DE GIRO").first_or_create
Cuenta.where(codigo: "410111", formato: "DatosMercado", descripcion: "INSTALACIÓN DE CASETAS").first_or_create
Cuenta.where(codigo: "410112", formato: "DatosMercado", descripcion: "REAPERTURA DE PUESTO, LOCAL O CASETA").first_or_create
Cuenta.where(codigo: "410114", formato: "DatosMercado", descripcion: "PERMISO PARA REMODELACIÓN").first_or_create
Cuenta.where(codigo: "410116", formato: "DatosMercado", descripcion: "OTROS CONCEPTOS DE MERCADOS").first_or_create

Cuenta.where(codigo: "410201", formato: "DatosComun", descripcion: "TRASLADO DE CADÁVERES FUERA DEL MUNICIPIO").first_or_create
Cuenta.where(codigo: "410205", formato: "DatosComun", descripcion: "CONSTRUCCIÓN DE MONUMENTOS, BÓVEDAS, MAUSOLEOS").first_or_create
Cuenta.where(codigo: "410206", formato: "DatosComun", descripcion: "INHUMACIÓN").first_or_create
Cuenta.where(codigo: "410207", formato: "DatosComun", descripcion: "EXHUMACIÓN").first_or_create
Cuenta.where(codigo: "410208", formato: "DatosComun", descripcion: "PERPETUIDAD").first_or_create
Cuenta.where(codigo: "410210", formato: "DatosComun", descripcion: "SERVICIOS DE REINHUMACIÓN").first_or_create
Cuenta.where(codigo: "410211", formato: "DatosComun", descripcion: "DEPÓSITOS DE RESTOS EN NICHOS O GAVETAS").first_or_create
Cuenta.where(codigo: "410212", formato: "DatosComun", descripcion: "CONSTRUCCIÓN, RECONSTRUCCIÓN O PROFUNDIZACIÓN DE FOSAS").first_or_create
Cuenta.where(codigo: "410213", formato: "DatosComun", descripcion: "CONSTRUCCIÓN O REPARACIÓN DE MONUMENTOS").first_or_create
Cuenta.where(codigo: "410214", formato: "DatosComun", descripcion: "MANTENIMIENTO DE PASILLOS, ANDENES Y SERVICIOS GENERALES DE LOS PANTEONES").first_or_create
Cuenta.where(codigo: "410215", formato: "DatosComun", descripcion: "CERTIFICADOS POR EXPEDICIÓN DE ANTECEDENTES DE TÍTULO O CAMBIO DE TITULAR").first_or_create
Cuenta.where(codigo: "410220", formato: "DatosComun", descripcion: "DESMONTE Y MONTE DE MONUMENTOS").first_or_create
Cuenta.where(codigo: "410221", formato: "DatosComun", descripcion: "OTROS CONCEPTOS DE PANTEONES").first_or_create

#Cuenta.where(codigo: "410301", descripcion: "TRASLADO DE GANADO").first_or_create
#Cuenta.where(codigo: "410302", descripcion: "USO DE CORRAL").first_or_create
#Cuenta.where(codigo: "410306", descripcion: "MATANZA DE GANADO VACUNO POR CABEZA").first_or_create
#Cuenta.where(codigo: "410307", descripcion: "MATANZA DE GANADO PORCINO POR CABEZA").first_or_create
#Cuenta.where(codigo: "410308", descripcion: "MATANZA DE GANADO OVINO POR CABEZA").first_or_create
#Cuenta.where(codigo: "410309", descripcion: "MATANZA DE GANADO LANAR O CABRÍO POR CABEZA").first_or_create
#Cuenta.where(codigo: "410311", descripcion: "MATANZA DE OTROS ANIMALES").first_or_create
#Cuenta.where(codigo: "410312", descripcion: "REGISTRO DE FIERROS, MARCAS, ARETES Y SEÑALES DE SANGRE").first_or_create
#Cuenta.where(codigo: "410313", descripcion: "REFRENDO DE FIERROS, MARCAS, ARETES Y SEÑALES DE SANGRE").first_or_create
#Cuenta.where(codigo: "410314", descripcion: "OTROS CONCEPTOS DE RASTRO").first_or_create
#Cuenta.where(codigo: "430101", descripcion: "ALUMBRADO PÚBLICO").first_or_create
Cuenta.where(codigo: "430201", formato: "DatosBasura", descripcion: "RECOLECCIÓN DE BASURA EN ÁREA COMERCIAL").first_or_create
Cuenta.where(codigo: "430202", formato: "DatosBasura", descripcion: "RECOLECCIÓN DE BASURA EN ÁREA INDUSTRIAL").first_or_create
Cuenta.where(codigo: "430203", formato: "DatosBasura", descripcion: "RECOLECCIÓN DE BASURA EN CASA-HABITACIÓN").first_or_create
#Cuenta.where(codigo: "430206", descripcion: "OTROS CONCEPTOS DE ASEO PÚBLICO").first_or_create
#Cuenta.where(codigo: "430401", descripcion: "COPIAS DE DOCUMENTOS EXISTENTES EN LOS ARCHIVOS MUNICIPALES POR HOJA").first_or_create
Cuenta.where(codigo: "430402", formato: "DatosCertificacion", descripcion: "EXPEDICIÓN DE CERTIFICADOS DE RESIDENCIA, ORIGEN, DEPENDENCIA ECONÓMICA, DE SITUACIÓN FISCAL, DE CONTRIBUYENTES INSCRITOS EN LA TESORERÍA MUNICIPAL Y DE MORADA CONYUGAL").first_or_create
Cuenta.where(codigo: "430403", formato: "DatosCertificacion", descripcion: "CERTIFICACIÓN DE REGISTRO FISCAL DE BIENES INMUEBLES EN EL PADRÓN").first_or_create
Cuenta.where(codigo: "430404", formato: "DatosCertificacion", descripcion: "CERTIFICACIÓN DE LA SUPERFICIE DE UN PREDIO").first_or_create
Cuenta.where(codigo: "430405", formato: "DatosCertificacion", descripcion: "CERTIFICACIÓN DE LA UBICACIÓN DE UN INMUEBLE").first_or_create
Cuenta.where(codigo: "430406", formato: "DatosCertificacion", descripcion: "BÚSQUEDA DE DOCUMENTOS").first_or_create
Cuenta.where(codigo: "430407", formato: "DatosCertificacion", descripcion: "CONSTANCIAS Y COPIAS CERTIFICADAS DISTINTAS A LAS ANTERIORES").first_or_create
Cuenta.where(codigo: "430408", formato: "DatosCertificacion", descripcion: "OTROS CONCEPTOS DE CERTIFICACIONES, CONSTANCIAS Y LEGALIZACIONES").first_or_create
Cuenta.where(codigo: "430501", formato: "DatosLicenciaConstruccion", descripcion: "PERMISOS DE CONSTRUCCIÓN, RECONSTRUCCIÓN Y AMPLIACIÓN DE INMUEBLES").first_or_create
Cuenta.where(codigo: "430502", formato: "DatosLicenciaConstruccion", descripcion: "REMODELACIÓN DE BARDAS Y FACHADAS DE FINCAS URBANAS Y RÚSTICAS").first_or_create
Cuenta.where(codigo: "430503", formato: "DatosLicenciaConstruccion", descripcion: "DEMOLICIÓN DE CONSTRUCCIONES").first_or_create
Cuenta.where(codigo: "430504", formato: "DatosLicenciaPredio", descripcion: "ASIGNACIÓN DE NÚMERO OFICIAL A PREDIOS").first_or_create
#Cuenta.where(codigo: "430505", descripcion: "ALINEACIÓN Y USO DE SUELO").first_or_create
#Cuenta.where(codigo: "430506", descripcion: "RENOVACIÓN DE LICENCIAS DE CONSTRUCCIÓN").first_or_create
#Cuenta.where(codigo: "430507", descripcion: "RETIRO DE SELLO DE OBRA SUSPENDIDA").first_or_create
#Cuenta.where(codigo: "430508", descripcion: "REGULARIZACIÓN DE CONSTRUCCIÓN DE CASA HABITACIÓN, COMERCIAL E INDUSTRIAL").first_or_create
#Cuenta.where(codigo: "430510", descripcion: "PERMISOS PARA FRACCIONAMIENTO").first_or_create
#Cuenta.where(codigo: "430511", descripcion: "CONSTITUCIÓN DEL RÉGIMEN EN CONDOMINIO").first_or_create
#Cuenta.where(codigo: "430512", descripcion: "APROBACIÓN Y REVISIÓN DE PLANOS").first_or_create
#Cuenta.where(codigo: "430513", descripcion: "OTROS CONCEPTOS DE PERMISOS EN MATERIA DE CONSTRUCCIÓN").first_or_create
Cuenta.where(codigo: "430601", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS Y REFRENDOS COMERCIAL").first_or_create
Cuenta.where(codigo: "430602", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS Y REFRENDOS INDUSTRIAL").first_or_create
Cuenta.where(codigo: "430603", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS Y REFRENDOS SERVICIOS").first_or_create
Cuenta.where(codigo: "430701", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS EN ENVASES CERRADOS").first_or_create
Cuenta.where(codigo: "430702", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS EN ENVASES ABIERTOS").first_or_create
Cuenta.where(codigo: "430703", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR VENTA AL COPEO DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430704", formato: "DatosLicenciaComercial", descripcion: "PERMISOS TEMPORALES DE COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430705", formato: "DatosLicenciaComercial", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR FUNCIONAMIENTO EN HORARIO EXTRAORDINARIO DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430706", formato: "DatosLicenciaComercial", descripcion: "REVALIDACIÓN ANUAL DE LICENCIAS DE FUNCIONAMIENTO, DISTRIBUCIÓN Y COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430707", formato: "DatosLicenciaComercial", descripcion: "AUTORIZACIÓN DE MODIFICACIONES A LAS LICENCIAS PARA EL FUNCIONAMIENTO, DISTRIBUCIÓN Y COMERCIALIZACIÓN").first_or_create
Cuenta.where(codigo: "430708", formato: "DatosLicenciaComercial", descripcion: "OTROS CONCEPTOS DE LICENCIAS Y REFRENDOS DE FUNCIONAMIENTO COMERCIAL, INDUSTRIAL Y DE SERVICIOS").first_or_create
Cuenta.where(codigo: "430801", formato: "DatosPermisoPublicidad", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE PARED, ADOSADOS O AZOTEAS").first_or_create
Cuenta.where(codigo: "430802", formato: "DatosPermisoPublicidad", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE PINTADO O INTEGRADO EN ESCAPARATE O TOLDO").first_or_create
Cuenta.where(codigo: "430803", formato: "DatosPermisoPublicidad", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE ANUNCIOS COLOCADOS").first_or_create
Cuenta.where(codigo: "430804", formato: "DatosPermisoPublicidad", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE DIFUSIÓN FONÉTICA DE PUBLICIDAD POR UNIDAD DE SONIDO").first_or_create
Cuenta.where(codigo: "430806", formato: "DatosPermisoPublicidad", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE CARTELERAS DE CINES, CIRCOS, TEATROS, OTROS").first_or_create
#Cuenta.where(codigo: "430913", descripcion: "OTROS CONCEPTOS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(codigo: "431001", descripcion: "CONSULTA MÉDICA").first_or_create
#Cuenta.where(codigo: "431003", descripcion: "SERVICIOS PRESTADOS PARA EL CONTROL DE ENFERMEDADES DE TRANSMISIÓN SEXUAL").first_or_create
#Cuenta.where(codigo: "431005", descripcion: "CONSULTA DE ODONTOLOGÍA").first_or_create
#Cuenta.where(codigo: "431007", descripcion: "SESIÓN DE TERAPIAS FÍSICAS").first_or_create
#Cuenta.where(codigo: "431011", descripcion: "OTROS SERVICIOS PRESTADOS EN MATERIA DE SALUD Y CONTROL DE ENFERMEDADES").first_or_create
#Cuenta.where(codigo: "431101", descripcion: "SANITARIO PÚBLICO").first_or_create
#Cuenta.where(codigo: "431401", descripcion: "SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA ELEMENTO CONTRATADO POR 12 HRS.").first_or_create
#Cuenta.where(codigo: "431402", descripcion: "SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA ELEMENTO CONTRATADO POR 24 HRS.").first_or_create
#Cuenta.where(codigo: "431403", descripcion: "OTROS SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA").first_or_create
Cuenta.where(codigo: "431501", formato: "DatosPermisoCarga", descripcion: "PERMISO PROVISIONAL PARA CARGA Y DESCARGA").first_or_create
Cuenta.where(codigo: "431502", formato: "DatosMultaTransito", descripcion: "SERVICIOS DE ARRASTRE EN GRUA").first_or_create
#Cuenta.where(codigo: "431505", descripcion: "SERVICIOS ESPECIALES PATRULLA").first_or_create
#Cuenta.where(codigo: "431506", descripcion: "SERVICIOS ESPECIALES ELEMENTO PEDESTRE").first_or_create
#Cuenta.where(codigo: "431507", descripcion: "SERVICIOS ESPECIALES OTROS").first_or_create
#Cuenta.where(codigo: "431701", descripcion: "ESTACIONAMIENTO PERMANENTE").first_or_create
#Cuenta.where(codigo: "431702", descripcion: "ESTACIONAMIENTO DE VEHICULOS DE  ALQUILER O DE CARGA").first_or_create
#Cuenta.where(codigo: "431706", descripcion: "OCUPACION DE LA VIA PUBLICA").first_or_create
Cuenta.where(codigo: "431901", formato: "DatosPadronContratista", descripcion: "INSCRIPCION  AL PADRON DE CONTRATISTAS DE OBRA PUBLICA").first_or_create
Cuenta.where(codigo: "431902", formato: "DatosCincoMillar", descripcion: "CONTRATOS  DE OBRA PÚBLICA Y SERVICIOS 5 AL MILLAR").first_or_create
#Cuenta.where(codigo: "450101", descripcion: "MULTAS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(codigo: "450102", descripcion: "MULTAS DE OTROS DERECHOS").first_or_create
#Cuenta.where(codigo: "450201", descripcion: "RECARGOS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(codigo: "450202", descripcion: "RECARGOS DE OTROS DERECHOS").first_or_create
Cuenta.where(codigo: "450301", formato: "DatosAgua", descripcion: "GASTOS DE EJECUCIÓN DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
#Cuenta.where(codigo: "450302", descripcion: "GASTOS DE EJECUCIÓN DE OTROS DERECHOS").first_or_create
#Cuenta.where(codigo: "510103", descripcion: "DERIVADO DE  ARRENDAMIENTO DE OTROS BIENES INMUEBLES").first_or_create
#Cuenta.where(codigo: "510201", descripcion: "DERIVADO DE ARRENDAMIENTO DE MAQUINARIA").first_or_create
#Cuenta.where(codigo: "510403", descripcion: "BASES PARA LICITACIÓN PÚBLICA").first_or_create
#Cuenta.where(codigo: "510404", descripcion: "BASES PARA INVITACIÓN RESTRINGIDA").first_or_create
#Cuenta.where(codigo: "510501", descripcion: "PRODUCTOS FINANCIEROS DEL RAMO 28 CHEQUES").first_or_create
#Cuenta.where(codigo: "510601", descripcion: "PRODUCTOS FINANCIEROS DEL FONDO III CHEQUES").first_or_create
#Cuenta.where(codigo: "510701", descripcion: "PRODUCTOS FINANCIEROS DEL FONDO IV CHEQUES").first_or_create
#Cuenta.where(codigo: "520201", descripcion: "ENAJENACION DE BIENES MUEBLES E INTANGIBLES").first_or_create
Cuenta.where(codigo: "610101", formato: "DatosMultaAdministrativa", descripcion: "MULTAS ADMINISTRATIVAS IMPUESTAS POR EL MUNICIPIO").first_or_create
#Cuenta.where(codigo: "610102", descripcion: "OTRAS MULTAS NO DESCRITAS ANTERIORMENTE").first_or_create
#Cuenta.where(codigo: "610301", descripcion: "REINTEGRO POR RESPONSABILIDAD DE REVISIÓN DE CUENTA PÚBLICA").first_or_create
#Cuenta.where(codigo: "610302", descripcion: "REINTEGRO POR RECUPERACIÓN DE OBRA PÚBLICA").first_or_create
#Cuenta.where(codigo: "610303", descripcion: "RECUPERACIÓN DE FIANZAS DE CUMPLIMIENTO").first_or_create
#Cuenta.where(codigo: "610304", descripcion: "RECUPERACIÓN DE FIANZAS DE ANTICIPO").first_or_create
#Cuenta.where(codigo: "610305", descripcion: "RECUPERACIÓN DE FIANZAS DE VICIOS OCULTOS").first_or_create
#Cuenta.where(codigo: "610501", descripcion: "APORTACION DE BENEFICIARIOS").first_or_create
#Cuenta.where(codigo: "610601", descripcion: "MULTAS DE APROVECHAMIENTOS POR PAGO EXTEMPORÁNEO").first_or_create
#Cuenta.where(codigo: "610602", descripcion: "RECARGOS DE APROVECHAMIENTOS POR INCUMPLIMIENTO DE CRÉDITOS FISCALES").first_or_create
#Cuenta.where(codigo: "610603", descripcion: "GASTOS DE EJECUCION DE APROVECHAMIENTOS").first_or_create
#Cuenta.where(codigo: "610702", descripcion: "DONATIVOS EN EFECTIVO").first_or_create
#Cuenta.where(codigo: "610703", descripcion: "DONACIONES DE MATERIALES Y SUMINISTROS").first_or_create
#Cuenta.where(codigo: "620103", descripcion: "DONACIONES RECIBIDAS DE OTROS BIENES INMUEBLES").first_or_create
#Cuenta.where(codigo: "620201", descripcion: "DONACIONES RECIBIDAS DE BIENES MUEBLES E INTANGIBLES").first_or_create
#Cuenta.where(codigo: "810101", descripcion: "FONDO DE PARTICIPACIONES").first_or_create
#Cuenta.where(codigo: "810201", descripcion: "FONDO DE FOMENTO").first_or_create
#Cuenta.where(codigo: "810301", descripcion: "FONDO DE COMPENSACIONES").first_or_create
#Cuenta.where(codigo: "810401", descripcion: "FOGADI").first_or_create
#Cuenta.where(codigo: "810701", descripcion: "ISR SALARIOS").first_or_create
#Cuenta.where(codigo: "820101", descripcion: "FISMDF").first_or_create
#Cuenta.where(codigo: "820201", descripcion: "FORTAMUN").first_or_create
#Cuenta.where(codigo: "830103", descripcion: "CONVENIOS FEDERALES PETROLEOS MEXICANOS").first_or_create
#Cuenta.where(codigo: "830244", descripcion: "SECRETARÍA DE DESARROLLO AGRARIO, TERRITORIAL Y URBANO (SEDATU)").first_or_create
#Cuenta.where(codigo: "830301", descripcion: "PROGRAMAS ESTATALES PROGRAMA").first_or_create
#Cuenta.where(codigo: "830401", descripcion: "CONVENIOS PARTICULARES PERSONA MORAL").first_or_create
#Cuenta.where(codigo: "830402", descripcion: "CONVENIOS PARTICULARES PERSONA FÍSICA").first_or_create
#Cuenta.where(codigo: "940101", descripcion: "BECAS").first_or_create
#Cuenta.where(codigo: "010101", descripcion: "EMPRESTITOS BANOBRAS").first_or_create

##Cuenta.first_or_initialize(codigo: "6107005", descripcion: " DERECHOS POR OTORGAMIENTO DE LA COMISION Y POR ELUSO O GOSE DE LA ZOFEMAT").first_or_create
