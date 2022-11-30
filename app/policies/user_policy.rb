class UserPolicy < ApplicationPolicy
  class Scope < Scope

    #   scope.all
    # end
  end
  def show?
    true
  end
end
