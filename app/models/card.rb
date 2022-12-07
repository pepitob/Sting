class Card < ApplicationRecord
  belongs_to :participation
  after_create :set_card

  private

  def set_card
    self.used = false
    self.value = [-0.1, -0.2, -0.35, 0.1, 0.2, 0.35].sample
    case value
    when -0.1 then self.action = "neg10_card.png"
    when -0.2 then self.action = "neg20_card.png"
    when -0.35 then self.action = "neg35_card.png"
    when 0.1 then self.action = "pos10_card.png"
    when 0.2 then self.action = "pos20_card.png"
    else self.action = "pos35_card.png"
    end
    self.save!
  end
end
