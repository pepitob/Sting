class OrderPolicy < ApplicationPolicy
  def new?
    ture
  end

  def show?
    true
  end
end
