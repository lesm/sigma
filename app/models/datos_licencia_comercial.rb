class DatosLicenciaComercial < DatosConcepto
  validates :fecha, :fecha_refrendo, :serie, :folio, presence: true
end
