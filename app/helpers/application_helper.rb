module ApplicationHelper
  def para_admin?
    current_usuario.admin?
  end

  def para_cajero?
    current_usuario.cajero?
  end

  def cuenta_ids
    Cuenta.all.map { |c| [c, c.id] }
  end

  def contribuyente_ids
    Contribuyente.all.map { |c| [c, c.id] }
  end

  def cuenta_codigos
    Cuenta.all.map { |c| [c, c.codigo] }
  end
end
