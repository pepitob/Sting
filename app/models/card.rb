class Card < ApplicationRecord
  belongs_to :participation
  belongs_to :weekly_progress
  after_create :set_card

  private

  def set_card
    self.used = false
    self.value = [-0.1, -0.2, -0.35, 0.1, 0.2, 0.35].sample
    if value.negative?
      self.action = "Mad Stingy"
    else
      self.action = "Stingy"
    end
  end

end
