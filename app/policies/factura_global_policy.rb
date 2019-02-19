class FacturaGlobalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      scope.all
    end
  end

  def new?
    user.cajero?
  end
end
