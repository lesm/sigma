class DatosLicenciaFusion < DatosConcepto
  validates :folio, :serie, :fecha, presence: true
end

