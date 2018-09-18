class ChangeAttributeNameToCierreCaja < ActiveRecord::Migration[5.2]
  def change
    rename_column :cierre_cajas, :monto, :monto_sistema
    add_column :cierre_cajas, :monto_cajero, :decimal, default: 0
  end
end
