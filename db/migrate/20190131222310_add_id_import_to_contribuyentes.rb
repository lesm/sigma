class AddIdImportToContribuyentes < ActiveRecord::Migration[5.2]
  def change
    add_column :contribuyentes, :id_import, :integer
  end
end
