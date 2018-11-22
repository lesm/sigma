class HistorialCajaPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin?  
  end

  def new?
    create?
  end

  def create?
    user.cajero?
  end
end
