class AddAttributesToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :clave_producto, :string
    add_column :cuentas, :clave_unidad, :string
  end
end
