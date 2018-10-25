class ChangeReferencesContribuyenteToCajeros < ActiveRecord::Migration[5.2]
  def change
    remove_reference :contribuyentes, :cajero, foreign_key: { to_table: :usuarios }
    add_reference :usuarios, :contribuyente, foreign_key: true
  end
end
