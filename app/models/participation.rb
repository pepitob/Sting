class Participation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  has_many :cards
end
