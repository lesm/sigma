class DatosTrasladoDominio < DatosConcepto
  validates :folio, :clave_catastral, :fecha,
    :numero_cuenta, :ubicacion, :base_catastral, 
    :impuesto_predial, presence: true
    #contribuyente
end
