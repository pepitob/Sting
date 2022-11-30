class Workout < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :date, presence: true
  validates :qty, presence: true
  validates :unit, presence: true

end
