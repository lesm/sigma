class CreateCuentas < ActiveRecord::Migration[5.2]
  def change
    create_table :cuentas do |t|
      t.string :codigo,      null: false
      t.string :descripcion, null: false

      t.timestamps
    end
  end
end
