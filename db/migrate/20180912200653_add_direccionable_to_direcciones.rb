class AddDireccionableToDirecciones < ActiveRecord::Migration[5.2]
  def change
    add_reference :direcciones, :direccionable, polymorphic: true
  end
end
