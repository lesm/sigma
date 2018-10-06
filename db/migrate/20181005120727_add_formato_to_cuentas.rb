class AddFormatoToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :formato, :string
  end
end
