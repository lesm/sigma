class AddNumeroMunicipioToEmisores < ActiveRecord::Migration[5.2]
  def change
    add_column :emisores, :numero_municipio, :string
  end
end
