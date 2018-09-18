class ChangeAttributeNameToArqueo < ActiveRecord::Migration[5.2]
  def change
    rename_column :arqueos, :monto, :monto_sistema
    add_column :arqueos, :monto_cajero, :decimal, default: 0
  end
end
