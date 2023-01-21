class OrderPolicy < ApplicationPolicy
  def new?
    user.present?
  end
end
