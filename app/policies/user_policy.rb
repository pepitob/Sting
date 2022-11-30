class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def show?
      true
    end
    #   scope.all
    # end
  end
end
