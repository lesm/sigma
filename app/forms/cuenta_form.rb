class CuentaForm
  include ActiveModel::Model

  attr_accessor :contribuyente_id, :cuenta_ids
  validates :contribuyente_id, :cuenta_ids, presence: true

  def save
    valid? 
  end
end
