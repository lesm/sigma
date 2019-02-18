class FacturaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      scope.all
    end
  end

  def show?
    user.cajero? 
  end
end
