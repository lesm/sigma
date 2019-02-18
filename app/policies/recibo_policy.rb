class ReciboPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      scope.includes(:contribuyente).all
    end
  end

  def show?
    create?
  end

  def create?
    user.cajero?
  end
end
