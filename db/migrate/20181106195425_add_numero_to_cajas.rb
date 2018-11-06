class AddNumeroToCajas < ActiveRecord::Migration[5.2]
  def change
    add_column :cajas, :numero, :integer
  end
end
