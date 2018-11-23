class ContribuyentePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError, "Usuario sin permisos." unless user.cajero?
      scope.all
    end
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

  def edit?
    create?
  end

  def update?
    create?
  end
end
