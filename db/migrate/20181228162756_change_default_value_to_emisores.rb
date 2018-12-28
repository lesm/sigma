class ChangeDefaultValueToEmisores < ActiveRecord::Migration[5.2]
  def change
    change_column_default :emisores, :regimen_fiscal, "603 - Personas morales con fines no lucrativos"
  end
end
