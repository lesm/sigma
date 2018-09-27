class AddReferencesCajeroToContribuyentes < ActiveRecord::Migration[5.2]
  def change
    add_reference :contribuyentes, :cajero, foreign_key: { to_table: :usuarios }
  end
end
