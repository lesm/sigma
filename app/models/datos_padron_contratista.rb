class DatosPadronContratista < DatosConcepto
  validates :fecha, :nombre_contratista, presence: true
end
