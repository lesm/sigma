class ContribuyentePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      scope.all
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
