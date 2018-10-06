class DatosAgua < DatosConcepto
  validates :numero_contrato, :numero_medidor, :lectura_actual,
   :lectura_anterior, :consumo, :ruta, :lecturista, :fecha_corte,
   presence: true
end
