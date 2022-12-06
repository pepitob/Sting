class Card < ApplicationRecord
  belongs_to :participation
  belongs_to :weekly_progress

  def set_value
    [-0.1, -0.2, -0.35, 0.1, 0.2, 0.35].sample
  end

  def set_action
    if value.negative
      "Sting progress"
    else
      "Flow progress"
    end
  end

end
