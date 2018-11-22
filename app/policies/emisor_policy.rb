class EmisorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.admin?
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user.admin?
  end

  def show?
    create?
  end

  def edit?
    create?
  end

  def update?
    create?
  end
end
