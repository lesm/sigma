module ApplicationHelper
  def cuenta_ids
    Cuenta.all.map { |c| [c, c.id] }
  end

  def contribuyente_ids
    Contribuyente.all.map { |c| [c, c.id] }
  end
end
