class AddAasmStateAttributeToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_column :comprobantes, :aasm_state, :string
  end
end
