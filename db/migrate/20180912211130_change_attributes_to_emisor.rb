class ChangeAttributesToEmisor < ActiveRecord::Migration[5.2]
  def change
    rename_column :emisores, :logo, :logotipo
    rename_column :emisores, :lugar_expedicion, :eslogan
  end
end
