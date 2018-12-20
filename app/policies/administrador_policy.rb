class AdministradorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    user.super_user? 
  end

  def show?
    create?
  end

  def update?
    create?
  end

  def edit?
    create? 
  end
end
