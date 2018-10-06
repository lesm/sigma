class DatosLicenciaPredio < DatosConcepto
  validates :folio, :serie, :fecha, presence: true
end
