class DatosCincoMillar < DatosConcepto
  validates :fecha, :localidad, :estimacion, :nombre_obra,
    presence: true
end
