class OrderPolicy < ApplicationPolicy
  def new?
    true
  end

  def show?
    true
  end
end
