class AddReferenceContribuyenteToDirecciones < ActiveRecord::Migration[5.2]
  def change
    add_reference :direcciones, :contribuyente, foreign_key: true
  end
end
