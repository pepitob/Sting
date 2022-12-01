class Workout < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :date, presence: true
  validates :distance, presence: true
  validates :duration, presence: true
end
