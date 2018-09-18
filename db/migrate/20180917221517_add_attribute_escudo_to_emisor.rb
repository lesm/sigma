class AddAttributeEscudoToEmisor < ActiveRecord::Migration[5.2]
  def change
    add_column :emisores, :escudo, :string
  end
end
