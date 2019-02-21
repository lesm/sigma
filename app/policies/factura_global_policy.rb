class FacturaGlobalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      scope.includes(:contribuyente).all
    end
  end

  def fechas?
    create?
  end

  def new?
    create?
  end

  def create?
    user.cajero?
  end

  def show?
    create?
  end
end
