class ChallengesController < ApplicationController
  # before_action :set_cards, only: %i[show]
  def index
    @challenges = policy_scope(Challenge) # returns a Challenge.all
    @challenges = @challenges.select { |challenge| challenge.participations.any? { |participation| participation.user == current_user }}
    @active_challenges = @challenges.select { |challenge| challenge.active? }
    @total_balance = 0
    @challenges.each do |challenge|
      if Date.today >= challenge.start_date
        week = challenge.current_week
        wp = WeeklyProgress.find_by(week_num: week, user_id: current_user, challenge_id: challenge.id)
        @total_balance += wp.balance
      else
        @total_balance += challenge.price
      end
    end
  end

  def new
    if current_user
      @challenge = Challenge.new # Needed to instantiate the form_with
      # when a user creates a challenge it creates a participation row
      @participation = Participation.new
      authorize @challenge
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.user = current_user
    authorize @challenge
    if @challenge.save
      # when a user creates a challenge it creates a participation row with that user and that challenge
      @participation = Participation.create(user: current_user, challenge: @challenge)
      redirect_to challenge_path(@challenge) # goes to show page
    else
      @challenge.start_date = @challenge.start_date
      @challenge.end_date = @challenge.end_date
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @message = Message.new
    @message.challenge = @challenge
    @challenge = Challenge.find(params[:id])
    authorize @challenge

    @user_participation = Participation.find_by(challenge: @challenge, user: current_user)
    @user_cards = Card.where(participation: @user_participation)
    if Date.today >= @challenge.start_date
      @week = @challenge.current_week
      @all_last_progress = WeeklyProgress.find_by(challenge: @challenge, week_num: @week)
      @user_last_progress = WeeklyProgress.find_by(challenge: @challenge, user: current_user, week_num: @week)
    else
      @user_last_progress = WeeklyProgress.find_by(challenge: @challenge, user: current_user, week_num: 1)
      @all_last_progress = WeeklyProgress.find_by(challenge: @challenge, week_num: 1)
    end
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :goal_qty, :start_date, :end_date, :unit, :price, :card_num, :category)
  end

  def participation_params
    params.require(:participation).permit(:user_id)
  end


  def message_params
    params.require(:message).permit(:content)
  end

end
