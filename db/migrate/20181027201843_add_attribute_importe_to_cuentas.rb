class AddAttributeImporteToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :importe, :money, default: 0
  end
end
