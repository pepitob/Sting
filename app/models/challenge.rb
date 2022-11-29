class Challenge < ApplicationRecord
  has_many :participations
  has_many :weeklyprogresss
  has_many :users, through: :participations
  has_many :cards, through: :participations

  TYPES = ["Running", "Walking", "Swimming", "Biking"]
  UNIT = ["Km", "Hours"]
  CARDS = [0..5]
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :end_date_after_start_date
  validates :start_date_after_today
  validates :goal_qty, presence: true
  validates :type, presence: true, inclusion: { in: TYPES }
  validates :unit, presence: true, inclusion: { in: UNIT }
  validates :card_num, presence: true, inclusion: { in: CARDS }
  validates :price, presence: true, numericality: { greater_than: 10 }
  before_save :set_challenge_qty
  # validate :range_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "Must be after the start date")
    end
  end

  def start_date_after_today
    if start_date < date.today
      errors.add(:start_date, "Must be today or after today")
    end
  end

  # def set_price
  #   price = 10
  # end

  def set_challenge_qty
    weeks = (end_date - start_date)/ 7
    #(60 * 60 * 24 * 7)
    challenge_qty = goal_qty * weeks
  end

  # def range_date
  #   date_ranges = Challenge.all.map { |b| b.start_date..b.end_date }
  #   date_ranges.each do |range|
  #     if range.include? start_date
  #       return errors.add(:start_date, "Already booked for this date")
  #     elsif range.include? end_date
  #       return errors.add(:end_date, "Already booked for this date")
  #     end
  #   end
  # end

end
