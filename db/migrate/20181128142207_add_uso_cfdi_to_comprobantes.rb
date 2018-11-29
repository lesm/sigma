class AddUsoCfdiToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_column :comprobantes, :uso_cfdi, :string
  end
end
