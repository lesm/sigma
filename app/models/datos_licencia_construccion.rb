class DatosLicenciaConstruccion < DatosConcepto
  validates :folio, :serie, :fecha, presence: true
end
