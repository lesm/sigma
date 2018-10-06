module ApplicationHelper
  def ids_for_cuenta_id
    Cuenta.all.map { |c| [c, c.id] }
  end
end
