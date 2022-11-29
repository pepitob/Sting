class WeeklyProgress < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_many :cards
end
