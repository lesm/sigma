class ReporteForm
  include ActiveModel::Model
  attr_accessor :nombre, :cajero_id, :fecha_inicial, :fecha_final,
    :cuenta_id
end
