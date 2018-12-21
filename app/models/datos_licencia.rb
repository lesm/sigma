class DatosLicencia < DatosConcepto
  validates :fecha, :serie, :folio, :years, presence: true
end
