class ContribuyentePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.personas_fisicas
      elsif user.cajero?
        scope.all
      else
        raise Pundit::NotAuthorizedError, "Usuario sin permisos."
      end
    end
  end

  def new?
    user.cajero?
  end

  def create?
    user.cajero? or user.admin?
  end

  def show?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end
end
