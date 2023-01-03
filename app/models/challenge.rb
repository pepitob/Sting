class Challenge < ApplicationRecord
  has_many :participations, dependent: :delete_all
  has_many :weekly_progresses, dependent: :delete_all
  has_many :participants, through: :participations, class_name: :user
  has_many :cards, through: :participations, dependent: :delete_all
  has_many :messages, dependent: :delete_all

  belongs_to :user

  CATEGORY = ["Run", "Walk", "Ride", "Swim"]
  UNIT = ["Km", "Hours"]
  CARDS = (0..5).to_a
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validate :start_date_after_today
  validates :goal_qty, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORY }
  validates :unit, presence: true, inclusion: { in: UNIT }
  validates :card_num, presence: true, inclusion: { in: CARDS }
  validates :price, presence: true, numericality: { greater_than: 10 }
  before_save :set_challenge_qty
  # validate :range_date

  def week_count
    (end_date - start_date).to_i / 7 + 1
  end

  def weekly_discount
    price / week_count
  end

  def members_count
    participations.count
  end

  def current_week
    return nil if Date.today < start_date || Date.today > end_date + 1

    if Date.today == (end_date + 1)
      ((Date.today - start_date).to_i / 7) + 2
    else
      ((Date.today - start_date).to_i / 7) + 1
    end
  end

  def is_update_day
    return true  if Date.today == end_date + 1
    return false if current_week == 1

    (((Date.today - start_date).to_i) % 7).zero?
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "Must be after the start date")
    end
  end

  def start_date_after_today
    errors.add(:start_date, "Must be today or after today") if start_date < Date.today
  end

  def set_challenge_qty
    if week_count <= 1
      self.challenge_qty = goal_qty
    else
      self.challenge_qty = goal_qty * week_count
    end
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
