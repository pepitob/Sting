class ParticipationsController < ApplicationController
  before_action :set_challenge, only: %i[new create select_participant ]

  def new
    authorize @challenge
    @participation = Participation.new
  end

  def create
    authorize @challenge
    @participation = Participation.new
    @participation.challenge = @challenge
    @participation.user = current_user
    if @participation.save
      # redirect_to challenge_path(@challenge)
      # redirect_to orders_path(participation_id: @participation.id)
      create_order

      flash[:success] = "You have joined the group!"
    else
      flash.now[:error] = "You already joined this challenge"
      render :new, status: :unprocessable_entity
    end
  end
  # if the user is not allowed to be here then redirect it to other page, also check params
  def select_participant
    #authorize this user_participation to access the page
    @user_participation = Participation.find(params[:id])
    authorize @user_participation
    @card = Card.find(params[:card])
    @participations = Participation.where(challenge: @challenge)
    @week = @challenge.current_week

  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def participation_params
    params.require(:participation).permit(:challenge_id, :user_id)
  end

  def create_order
    participation = @participation
    order  = Order.create!(participation: participation, amount: participation.challenge.price, state: 'pending')

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: participation.challenge.name,
        amount: participation.challenge.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
