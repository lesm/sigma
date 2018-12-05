class CajeroForm < ReporteForm
  validates :cajero_id, :fecha_inicial, :fecha_final, presence: true
end
