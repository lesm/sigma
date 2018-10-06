class DatosMultaTransito < DatosConcepto
  validates :fecha, :folio, :placa, presence: true
end
