class ChangeDefaultValueToComprobantes < ActiveRecord::Migration[5.2]
  def change
    change_column_default :comprobantes, :metodo_pago, "PUE - Pago en una sola exhibición"
  end
end
