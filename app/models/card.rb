class Card < ApplicationRecord
  belongs_to :participation
  belongs_to :weekly_progress
  belongs_to :user, through: :participation
  # before_save :set_value, :set_action


  private

  # def set_value
  #   card_options = [-0.1, -0.2, -0.35, 0.1, 0.2, 0.35].sample
  #   value = card_options.sample
  # end

  # def set_action
  #   if value < 0
  #     action = "Sting progress"
  #   else
  #     action = "Flow progress"
  # end

end
