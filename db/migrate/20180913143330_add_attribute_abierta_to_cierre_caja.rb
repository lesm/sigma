class AddAttributeAbiertaToCierreCaja < ActiveRecord::Migration[5.2]
  def change
    add_column :cierre_cajas, :abierta, :boolean, default: true
  end
end
