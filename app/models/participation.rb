class Participation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  has_many :cards
  after_create :create_weekly_progresses


  def create_weekly_progresses
    challenge.week_count.times do |i|
      weekly_progress = WeeklyProgress.new
      weekly_progress.user = user
      weekly_progress.challenge = challenge
      weekly_progress.week_num = i + 1
      weekly_progress.progress = 0
      if i == 0
        weekly_progress.balance = challenge.price
      else
        weekly_progress.balance = 0
      end
      weekly_progress.unit = challenge.unit
      weekly_progress.save!
    end
  end


end
