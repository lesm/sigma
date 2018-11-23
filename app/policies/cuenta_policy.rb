class CuentaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      unless user.admin? or user.cajero?
        raise Pundit::NotAuthorizedError, "Usuario sin permisos."
      end
      scope.all
    end
  end

  def show?
    create?
  end

  def edit?
    user.admin?
  end

  def update?
    edit?
  end

  def new?
    create? 
  end

  def create?
    user.admin? or user.cajero?
  end
end
