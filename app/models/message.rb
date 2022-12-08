class Message < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  def sender?(current_user)
    user.id == current_user.id
  end
end
