puts "Creando Cuentas..."

Cuenta.where(codigo: "110101", descripcion: "RIFAS").first_or_create
Cuenta.where(codigo: "110102", descripcion: "SORTEOS").first_or_create
Cuenta.where(codigo: "110103", descripcion: "LOTERÍAS").first_or_create
Cuenta.where(codigo: "110104", descripcion: "CONCURSOS").first_or_create
Cuenta.where(codigo: "110201", descripcion: "TEATROS").first_or_create
Cuenta.where(codigo: "110202", descripcion: "CIRCOS").first_or_create
Cuenta.where(codigo: "110203", descripcion: "FERIAS").first_or_create
Cuenta.where(codigo: "110204", descripcion: "BOX").first_or_create
Cuenta.where(codigo: "110205", descripcion: "LUCHA LIBRE").first_or_create
Cuenta.where(codigo: "110206", descripcion: "BAILES").first_or_create
Cuenta.where(codigo: "110207", descripcion: "PRESENTACIÓN DE ARTISTAS").first_or_create
Cuenta.where(codigo: "110208", descripcion: "KERMÉS").first_or_create
Cuenta.where(codigo: "110209", descripcion: "APARATOS MECÁNICOS").first_or_create
Cuenta.where(codigo: "110210", descripcion: "APARATOS ELECTRÓNICOS").first_or_create
Cuenta.where(codigo: "110211", descripcion: "APARATOS ELÉCTRICOS").first_or_create
Cuenta.where(codigo: "110212", descripcion: "APARATOS ELECTROMECÁNICOS").first_or_create
Cuenta.where(codigo: "110213", descripcion: "MESAS DE JUEGO").first_or_create
Cuenta.where(codigo: "120101", descripcion: "PREDIAL URBANOS").first_or_create
Cuenta.where(codigo: "120102", descripcion: "PREDIAL RUSTICOS").first_or_create
Cuenta.where(codigo: "120103", descripcion: "PREDIAL EJIDALES").first_or_create
Cuenta.where(codigo: "120104", descripcion: "PREDIAL COMUNALES").first_or_create
Cuenta.where(codigo: "120105", descripcion: "PREDIAL REZAGOS").first_or_create
Cuenta.where(codigo: "120201", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN RESIDENCIAL").first_or_create
Cuenta.where(codigo: "120202", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN TIPO MEDIO").first_or_create
Cuenta.where(codigo: "120203", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN POPULAR").first_or_create
Cuenta.where(codigo: "120204", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN DE INTERÉS SOCIAL").first_or_create
Cuenta.where(codigo: "120205", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES HABITACIÓN CAMPESTRE").first_or_create
Cuenta.where(codigo: "120206", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES GRANJA").first_or_create
Cuenta.where(codigo: "120207", descripcion: "FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES INDUSTRIAL").first_or_create
Cuenta.where(codigo: "130101", descripcion: "TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "170101", descripcion: "MULTAS DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(codigo: "170201", descripcion: "MULTAS DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(codigo: "170202", descripcion: "MULTAS DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(codigo: "170203", descripcion: "MULTAS DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(codigo: "170204", descripcion: "MULTAS DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "170205", descripcion: "MULTAS DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "170301", descripcion: "RECARGOS DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(codigo: "170401", descripcion: "RECARGOS DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(codigo: "170402", descripcion: "RECARGOS DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(codigo: "170403", descripcion: "RECARGOS DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(codigo: "170404", descripcion: "RECARGOS DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "170405", descripcion: "RECARGOS DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "170501", descripcion: "GASTOS DE EJECUCIÓN DE IMPUESTO PREDIAL").first_or_create
Cuenta.where(codigo: "170601", descripcion: "GASTOS DE EJECUCIÓN DE RIFAS, SORTEOS LOTERÍAS Y CONCURSOS").first_or_create
Cuenta.where(codigo: "170602", descripcion: "GASTOS DE EJECUCIÓN DE DIVERSIONES Y ESPECTÁCULOS PÚBLICOS").first_or_create
Cuenta.where(codigo: "170603", descripcion: "GASTOS DE EJECUCIÓN DE OTROS IMPUESTOS SOBRE LOS INGRESOS").first_or_create
Cuenta.where(codigo: "170604", descripcion: "GASTOS DE EJECUCIÓN DE FRACCIONAMIENTO Y FUSIÓN DE BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "170605", descripcion: "GASTOS DE EJECUCIÓN DE TRASLACIÓN DE DOMINIO").first_or_create
Cuenta.where(codigo: "310101", descripcion: "INTRODUCCIÓN DE AGUA POTABLE").first_or_create
Cuenta.where(codigo: "310102", descripcion: "INTRODUCCIÓN DE RED DE DRENAJE").first_or_create
Cuenta.where(codigo: "310103", descripcion: "ELECTRIFICACIÓN").first_or_create
Cuenta.where(codigo: "310104", descripcion: "REVESTIMIENTO DE CALLES M2").first_or_create
Cuenta.where(codigo: "310105", descripcion: "PAVIMENTACIÓN DE CALLES M2").first_or_create
Cuenta.where(codigo: "310106", descripcion: "BANQUETAS M2").first_or_create
Cuenta.where(codigo: "310107", descripcion: "GUARNICIONES METRO LINEAL").first_or_create
Cuenta.where(codigo: "310201", descripcion: "MULTAS DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(codigo: "310301", descripcion: "RECARGOS DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(codigo: "310401", descripcion: "GASTOS DE EJECUCIÓN DE CONTRIBUCIONES DE MEJORAS").first_or_create
Cuenta.where(codigo: "410101", descripcion: "PUESTOS FIJOS EN MERCADOS CONSTRUIDOS").first_or_create
Cuenta.where(codigo: "410102", descripcion: "PUESTOS SEMIFIJOS EN MERCADOS CONSTRUIDOS").first_or_create
Cuenta.where(codigo: "410103", descripcion: "PUESTOS FIJOS EN PLAZAS, CALLES O TERRENOS").first_or_create
Cuenta.where(codigo: "410104", descripcion: "PUESTOS SEMIFIJOS EN PLAZAS, CALLES O TERRENOS").first_or_create
Cuenta.where(codigo: "410105", descripcion: "CASETAS O PUESTOS UBICADOS EN LA VÍA PÚBLICA").first_or_create
Cuenta.where(codigo: "410106", descripcion: "VENDEDORES AMBULANTES O ESPORÁDICOS").first_or_create
Cuenta.where(codigo: "410107", descripcion: "OTORGAMIENTO, TRASPASO Y SUCESIÓN DE CONCESIÓN DE CASETA O PUESTO").first_or_create
Cuenta.where(codigo: "410109", descripcion: "REGULARIZACIÓN DE CONCESIONES").first_or_create
Cuenta.where(codigo: "410110", descripcion: "AMPLIACIÓN O CAMBIO DE GIRO").first_or_create
Cuenta.where(codigo: "410111", descripcion: "INSTALACIÓN DE CASETAS").first_or_create
Cuenta.where(codigo: "410112", descripcion: "REAPERTURA DE PUESTO, LOCAL O CASETA").first_or_create
Cuenta.where(codigo: "410114", descripcion: "PERMISO PARA REMODELACIÓN").first_or_create
Cuenta.where(codigo: "410116", descripcion: "OTROS CONCEPTOS DE MERCADOS").first_or_create
Cuenta.where(codigo: "410201", descripcion: "TRASLADO DE CADÁVERES FUERA DEL MUNICIPIO").first_or_create
Cuenta.where(codigo: "410205", descripcion: "CONSTRUCCIÓN DE MONUMENTOS, BÓVEDAS, MAUSOLEOS").first_or_create
Cuenta.where(codigo: "410206", descripcion: "INHUMACIÓN").first_or_create
Cuenta.where(codigo: "410207", descripcion: "EXHUMACIÓN").first_or_create
Cuenta.where(codigo: "410208", descripcion: "PERPETUIDAD").first_or_create
Cuenta.where(codigo: "410210", descripcion: "SERVICIOS DE REINHUMACIÓN").first_or_create
Cuenta.where(codigo: "410211", descripcion: "DEPÓSITOS DE RESTOS EN NICHOS O GAVETAS").first_or_create
Cuenta.where(codigo: "410212", descripcion: "CONSTRUCCIÓN, RECONSTRUCCIÓN O PROFUNDIZACIÓN DE FOSAS").first_or_create
Cuenta.where(codigo: "410213", descripcion: "CONSTRUCCIÓN O REPARACIÓN DE MONUMENTOS").first_or_create
Cuenta.where(codigo: "410214", descripcion: "MANTENIMIENTO DE PASILLOS, ANDENES Y SERVICIOS GENERALES DE LOS PANTEONES").first_or_create
Cuenta.where(codigo: "410215", descripcion: "CERTIFICADOS POR EXPEDICIÓN DE ANTECEDENTES DE TÍTULO O CAMBIO DE TITULAR").first_or_create
Cuenta.where(codigo: "410220", descripcion: "DESMONTE Y MONTE DE MONUMENTOS").first_or_create
Cuenta.where(codigo: "410221", descripcion: "OTROS CONCEPTOS DE PANTEONES").first_or_create
Cuenta.where(codigo: "410301", descripcion: "TRASLADO DE GANADO").first_or_create
Cuenta.where(codigo: "410302", descripcion: "USO DE CORRAL").first_or_create
Cuenta.where(codigo: "410306", descripcion: "MATANZA DE GANADO VACUNO POR CABEZA").first_or_create
Cuenta.where(codigo: "410307", descripcion: "MATANZA DE GANADO PORCINO POR CABEZA").first_or_create
Cuenta.where(codigo: "410308", descripcion: "MATANZA DE GANADO OVINO POR CABEZA").first_or_create
Cuenta.where(codigo: "410309", descripcion: "MATANZA DE GANADO LANAR O CABRÍO POR CABEZA").first_or_create
Cuenta.where(codigo: "410311", descripcion: "MATANZA DE OTROS ANIMALES").first_or_create
Cuenta.where(codigo: "410312", descripcion: "REGISTRO DE FIERROS, MARCAS, ARETES Y SEÑALES DE SANGRE").first_or_create
Cuenta.where(codigo: "410313", descripcion: "REFRENDO DE FIERROS, MARCAS, ARETES Y SEÑALES DE SANGRE").first_or_create
Cuenta.where(codigo: "410314", descripcion: "OTROS CONCEPTOS DE RASTRO").first_or_create
Cuenta.where(codigo: "430101", descripcion: "ALUMBRADO PÚBLICO").first_or_create
Cuenta.where(codigo: "430201", descripcion: "RECOLECCIÓN DE BASURA EN ÁREA COMERCIAL").first_or_create
Cuenta.where(codigo: "430202", descripcion: "RECOLECCIÓN DE BASURA EN ÁREA INDUSTRIAL").first_or_create
Cuenta.where(codigo: "430203", descripcion: "RECOLECCIÓN DE BASURA EN CASA-HABITACIÓN").first_or_create
Cuenta.where(codigo: "430206", descripcion: "OTROS CONCEPTOS DE ASEO PÚBLICO").first_or_create
Cuenta.where(codigo: "430401", descripcion: "COPIAS DE DOCUMENTOS EXISTENTES EN LOS ARCHIVOS MUNICIPALES POR HOJA").first_or_create
Cuenta.where(codigo: "430402", descripcion: "EXPEDICIÓN DE CERTIFICADOS DE RESIDENCIA, ORIGEN, DEPENDENCIA ECONÓMICA, DE SITUACIÓN FISCAL, DE CONTRIBUYENTES INSCRITOS EN LA TESORERÍA MUNICIPAL Y DE MORADA CONYUGAL").first_or_create
Cuenta.where(codigo: "430403", descripcion: "CERTIFICACIÓN DE REGISTRO FISCAL DE BIENES INMUEBLES EN EL PADRÓN").first_or_create
Cuenta.where(codigo: "430404", descripcion: "CERTIFICACIÓN DE LA SUPERFICIE DE UN PREDIO").first_or_create
Cuenta.where(codigo: "430405", descripcion: "CERTIFICACIÓN DE LA UBICACIÓN DE UN INMUEBLE").first_or_create
Cuenta.where(codigo: "430406", descripcion: "BÚSQUEDA DE DOCUMENTOS").first_or_create
Cuenta.where(codigo: "430407", descripcion: "CONSTANCIAS Y COPIAS CERTIFICADAS DISTINTAS A LAS ANTERIORES").first_or_create
Cuenta.where(codigo: "430408", descripcion: "OTROS CONCEPTOS DE CERTIFICACIONES, CONSTANCIAS Y LEGALIZACIONES").first_or_create
Cuenta.where(codigo: "430501", descripcion: "PERMISOS DE CONSTRUCCIÓN, RECONSTRUCCIÓN Y AMPLIACIÓN DE INMUEBLES").first_or_create
Cuenta.where(codigo: "430502", descripcion: "REMODELACIÓN DE BARDAS Y FACHADAS DE FINCAS URBANAS Y RÚSTICAS").first_or_create
Cuenta.where(codigo: "430503", descripcion: "DEMOLICIÓN DE CONSTRUCCIONES").first_or_create
Cuenta.where(codigo: "430504", descripcion: "ASIGNACIÓN DE NÚMERO OFICIAL A PREDIOS").first_or_create
Cuenta.where(codigo: "430505", descripcion: "ALINEACIÓN Y USO DE SUELO").first_or_create
Cuenta.where(codigo: "430506", descripcion: "RENOVACIÓN DE LICENCIAS DE CONSTRUCCIÓN").first_or_create
Cuenta.where(codigo: "430507", descripcion: "RETIRO DE SELLO DE OBRA SUSPENDIDA").first_or_create
Cuenta.where(codigo: "430508", descripcion: "REGULARIZACIÓN DE CONSTRUCCIÓN DE CASA HABITACIÓN, COMERCIAL E INDUSTRIAL").first_or_create
Cuenta.where(codigo: "430510", descripcion: "PERMISOS PARA FRACCIONAMIENTO").first_or_create
Cuenta.where(codigo: "430511", descripcion: "CONSTITUCIÓN DEL RÉGIMEN EN CONDOMINIO").first_or_create
Cuenta.where(codigo: "430512", descripcion: "APROBACIÓN Y REVISIÓN DE PLANOS").first_or_create
Cuenta.where(codigo: "430513", descripcion: "OTROS CONCEPTOS DE PERMISOS EN MATERIA DE CONSTRUCCIÓN").first_or_create
Cuenta.where(codigo: "430601", descripcion: "LICENCIAS Y REFRENDOS COMERCIAL").first_or_create
Cuenta.where(codigo: "430602", descripcion: "LICENCIAS Y REFRENDOS INDUSTRIAL").first_or_create
Cuenta.where(codigo: "430603", descripcion: "LICENCIAS Y REFRENDOS SERVICIOS").first_or_create
Cuenta.where(codigo: "430701", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS EN ENVASES CERRADOS").first_or_create
Cuenta.where(codigo: "430702", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS EN ENVASES ABIERTOS").first_or_create
Cuenta.where(codigo: "430703", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR VENTA AL COPEO DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430704", descripcion: "PERMISOS TEMPORALES DE COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430705", descripcion: "LICENCIAS, PERMISOS O AUTORIZACIONES POR FUNCIONAMIENTO EN HORARIO EXTRAORDINARIO DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430706", descripcion: "REVALIDACIÓN ANUAL DE LICENCIAS DE FUNCIONAMIENTO, DISTRIBUCIÓN Y COMERCIALIZACIÓN DE BEBIDAS ALCOHÓLICAS").first_or_create
Cuenta.where(codigo: "430707", descripcion: "AUTORIZACIÓN DE MODIFICACIONES A LAS LICENCIAS PARA EL FUNCIONAMIENTO, DISTRIBUCIÓN Y COMERCIALIZACIÓN").first_or_create
Cuenta.where(codigo: "430708", descripcion: "OTROS CONCEPTOS DE LICENCIAS Y REFRENDOS DE FUNCIONAMIENTO COMERCIAL, INDUSTRIAL Y DE SERVICIOS").first_or_create
Cuenta.where(codigo: "430801", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE PARED, ADOSADOS O AZOTEAS").first_or_create
Cuenta.where(codigo: "430802", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE PINTADO O INTEGRADO EN ESCAPARATE O TOLDO").first_or_create
Cuenta.where(codigo: "430803", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE ANUNCIOS COLOCADOS").first_or_create
Cuenta.where(codigo: "430804", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE DIFUSIÓN FONÉTICA DE PUBLICIDAD POR UNIDAD DE SONIDO").first_or_create
Cuenta.where(codigo: "430806", descripcion: "PERMISOS PARA ANUNCIOS Y PUBLICIDAD DE CARTELERAS DE CINES, CIRCOS, TEATROS, OTROS").first_or_create
Cuenta.where(codigo: "430913", descripcion: "OTROS CONCEPTOS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
Cuenta.where(codigo: "431001", descripcion: "CONSULTA MÉDICA").first_or_create
Cuenta.where(codigo: "431003", descripcion: "SERVICIOS PRESTADOS PARA EL CONTROL DE ENFERMEDADES DE TRANSMISIÓN SEXUAL").first_or_create
Cuenta.where(codigo: "431005", descripcion: "CONSULTA DE ODONTOLOGÍA").first_or_create
Cuenta.where(codigo: "431007", descripcion: "SESIÓN DE TERAPIAS FÍSICAS").first_or_create
Cuenta.where(codigo: "431011", descripcion: "OTROS SERVICIOS PRESTADOS EN MATERIA DE SALUD Y CONTROL DE ENFERMEDADES").first_or_create
Cuenta.where(codigo: "431101", descripcion: "SANITARIO PÚBLICO").first_or_create
Cuenta.where(codigo: "431401", descripcion: "SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA ELEMENTO CONTRATADO POR 12 HRS.").first_or_create
Cuenta.where(codigo: "431402", descripcion: "SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA ELEMENTO CONTRATADO POR 24 HRS.").first_or_create
Cuenta.where(codigo: "431403", descripcion: "OTROS SERVICIOS PRESTADOS POR LAS AUTORIDADES DE SEGURIDAD PÚBLICA").first_or_create
Cuenta.where(codigo: "431501", descripcion: "PERMISO PROVISIONAL PARA CARGA Y DESCARGA").first_or_create
Cuenta.where(codigo: "431502", descripcion: "SERVICIOS DE ARRASTRE EN GRUA").first_or_create
Cuenta.where(codigo: "431505", descripcion: "SERVICIOS ESPECIALES PATRULLA").first_or_create
Cuenta.where(codigo: "431506", descripcion: "SERVICIOS ESPECIALES ELEMENTO PEDESTRE").first_or_create
Cuenta.where(codigo: "431507", descripcion: "SERVICIOS ESPECIALES OTROS").first_or_create
Cuenta.where(codigo: "431701", descripcion: "ESTACIONAMIENTO PERMANENTE").first_or_create
Cuenta.where(codigo: "431702", descripcion: "ESTACIONAMIENTO DE VEHICULOS DE  ALQUILER O DE CARGA").first_or_create
Cuenta.where(codigo: "431706", descripcion: "OCUPACION DE LA VIA PUBLICA").first_or_create
Cuenta.where(codigo: "431901", descripcion: "INSCRIPCION  AL PADRON DE CONTRATISTAS DE OBRA PUBLICA").first_or_create
Cuenta.where(codigo: "431902", descripcion: "CONTRATOS  DE OBRA PÚBLICA Y SERVICIOS 5 AL MILLAR").first_or_create
Cuenta.where(codigo: "450101", descripcion: "MULTAS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
Cuenta.where(codigo: "450102", descripcion: "MULTAS DE OTROS DERECHOS").first_or_create
Cuenta.where(codigo: "450201", descripcion: "RECARGOS DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
Cuenta.where(codigo: "450202", descripcion: "RECARGOS DE OTROS DERECHOS").first_or_create
Cuenta.where(codigo: "450301", descripcion: "GASTOS DE EJECUCIÓN DE AGUA POTABLE, DRENAJE Y ALCANTARILLADO").first_or_create
Cuenta.where(codigo: "450302", descripcion: "GASTOS DE EJECUCIÓN DE OTROS DERECHOS").first_or_create
Cuenta.where(codigo: "510103", descripcion: "DERIVADO DE  ARRENDAMIENTO DE OTROS BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "510201", descripcion: "DERIVADO DE ARRENDAMIENTO DE MAQUINARIA").first_or_create
Cuenta.where(codigo: "510403", descripcion: "BASES PARA LICITACIÓN PÚBLICA").first_or_create
Cuenta.where(codigo: "510404", descripcion: "BASES PARA INVITACIÓN RESTRINGIDA").first_or_create
Cuenta.where(codigo: "510501", descripcion: "PRODUCTOS FINANCIEROS DEL RAMO 28 CHEQUES").first_or_create
Cuenta.where(codigo: "510601", descripcion: "PRODUCTOS FINANCIEROS DEL FONDO III CHEQUES").first_or_create
Cuenta.where(codigo: "510701", descripcion: "PRODUCTOS FINANCIEROS DEL FONDO IV CHEQUES").first_or_create
Cuenta.where(codigo: "520201", descripcion: "ENAJENACION DE BIENES MUEBLES E INTANGIBLES").first_or_create
Cuenta.where(codigo: "610101", descripcion: "MULTAS ADMINISTRATIVAS IMPUESTAS POR EL MUNICIPIO").first_or_create
Cuenta.where(codigo: "610102", descripcion: "OTRAS MULTAS NO DESCRITAS ANTERIORMENTE").first_or_create
Cuenta.where(codigo: "610301", descripcion: "REINTEGRO POR RESPONSABILIDAD DE REVISIÓN DE CUENTA PÚBLICA").first_or_create
Cuenta.where(codigo: "610302", descripcion: "REINTEGRO POR RECUPERACIÓN DE OBRA PÚBLICA").first_or_create
Cuenta.where(codigo: "610303", descripcion: "RECUPERACIÓN DE FIANZAS DE CUMPLIMIENTO").first_or_create
Cuenta.where(codigo: "610304", descripcion: "RECUPERACIÓN DE FIANZAS DE ANTICIPO").first_or_create
Cuenta.where(codigo: "610305", descripcion: "RECUPERACIÓN DE FIANZAS DE VICIOS OCULTOS").first_or_create
Cuenta.where(codigo: "610501", descripcion: "APORTACION DE BENEFICIARIOS").first_or_create
Cuenta.where(codigo: "610601", descripcion: "MULTAS DE APROVECHAMIENTOS POR PAGO EXTEMPORÁNEO").first_or_create
Cuenta.where(codigo: "610602", descripcion: "RECARGOS DE APROVECHAMIENTOS POR INCUMPLIMIENTO DE CRÉDITOS FISCALES").first_or_create
Cuenta.where(codigo: "610603", descripcion: "GASTOS DE EJECUCION DE APROVECHAMIENTOS").first_or_create
Cuenta.where(codigo: "610702", descripcion: "DONATIVOS EN EFECTIVO").first_or_create
Cuenta.where(codigo: "610703", descripcion: "DONACIONES DE MATERIALES Y SUMINISTROS").first_or_create
Cuenta.where(codigo: "620103", descripcion: "DONACIONES RECIBIDAS DE OTROS BIENES INMUEBLES").first_or_create
Cuenta.where(codigo: "620201", descripcion: "DONACIONES RECIBIDAS DE BIENES MUEBLES E INTANGIBLES").first_or_create
Cuenta.where(codigo: "810101", descripcion: "FONDO DE PARTICIPACIONES").first_or_create
Cuenta.where(codigo: "810201", descripcion: "FONDO DE FOMENTO").first_or_create
Cuenta.where(codigo: "810301", descripcion: "FONDO DE COMPENSACIONES").first_or_create
Cuenta.where(codigo: "810401", descripcion: "FOGADI").first_or_create
Cuenta.where(codigo: "810701", descripcion: "ISR SALARIOS").first_or_create
Cuenta.where(codigo: "820101", descripcion: "FISMDF").first_or_create
Cuenta.where(codigo: "820201", descripcion: "FORTAMUN").first_or_create
Cuenta.where(codigo: "830103", descripcion: "CONVENIOS FEDERALES PETROLEOS MEXICANOS").first_or_create
Cuenta.where(codigo: "830244", descripcion: "SECRETARÍA DE DESARROLLO AGRARIO, TERRITORIAL Y URBANO (SEDATU)").first_or_create
Cuenta.where(codigo: "830301", descripcion: "PROGRAMAS ESTATALES PROGRAMA").first_or_create
Cuenta.where(codigo: "830401", descripcion: "CONVENIOS PARTICULARES PERSONA MORAL").first_or_create
Cuenta.where(codigo: "830402", descripcion: "CONVENIOS PARTICULARES PERSONA FÍSICA").first_or_create
Cuenta.where(codigo: "940101", descripcion: "BECAS").first_or_create
Cuenta.where(codigo: "010101", descripcion: "EMPRESTITOS BANOBRAS").first_or_create

#Cuenta.first_or_initialize(codigo: "6107005", descripcion: " DERECHOS POR OTORGAMIENTO DE LA COMISION Y POR ELUSO O GOSE DE LA ZOFEMAT").first_or_create
