class ChangeDefaultValueMontoToCierreCaja < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cierre_cajas, :monto, from: nil, to: 0
    change_column_default :arqueos, :monto, from: nil, to: 0
  end
end
