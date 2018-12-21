class DatosPermisoPublicidad < DatosConcepto
  validates :fecha, :years, presence: true
end
