class Participation < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  has_many :cards, dependent: :delete_all
  after_create :create_weekly_progresses, :create_cards
  # , :create_order

  validates :user, uniqueness: { scope: :challenge, message: "You already joined the challenge" }

  def create_weekly_progresses
    challenge.week_count.times do |i|
      weekly_progress = WeeklyProgress.new
      weekly_progress.user = user
      weekly_progress.challenge = challenge
      weekly_progress.week_num = i + 1
      weekly_progress.progress = 0
      weekly_progress.week_goal = challenge.goal_qty
      weekly_progress.challenge_goal = challenge.challenge_qty
      if i == 0
        weekly_progress.balance = challenge.price
      else
        weekly_progress.balance = 0
      end
      weekly_progress.unit = challenge.unit
      weekly_progress.save!
    end
  end

  def create_cards
    challenge.card_num.times do
      Card.create(participation_id: self.id)
    end
  end

  # def create_order
  #   order = Order.create!(participation_id: id, amount: challenge.price, state: 'pending')
  #   participation = Participation.find(id)

  #   session = Stripe::Checkout::Session.create(
  #     payment_method_types: ['card'],
  #     line_items: [{
  #       name: participation.challenge.name,
  #       amount: participation.challenge.price_cents,
  #       currency: 'eur',
  #       quantity: 1
  #     }],
  #     success_url: order_url(order),
  #     cancel_url: order_url(order)
  #   )

  #   order.update(checkout_session_id: session.id)
  #   redirect_to new_order_payment_path(order)
  # end
end
