class FacturaGlobalForm
  include ActiveModel::Model
  attr_accessor :fecha_inicial, :fecha_final

  validates :fecha_inicial, :fecha_final, presence: true
end
