class AddAutomaticoToCierreCajas < ActiveRecord::Migration[5.2]
  def change
    add_column :cierre_cajas, :automatico, :boolean, default: false
  end
end
