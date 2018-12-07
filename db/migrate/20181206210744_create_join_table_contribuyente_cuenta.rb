class CreateJoinTableContribuyenteCuenta < ActiveRecord::Migration[5.2]
  def change
    create_join_table :contribuyentes, :cuentas do |t|
      t.index [:contribuyente_id, :cuenta_id]
      t.index [:cuenta_id, :contribuyente_id]
    end
  end
end
