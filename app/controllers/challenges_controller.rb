class ChallengesController < ApplicationController
  def index
    @challenges = policy_scope(Challenge)
  end

  def new
    if current_user
      @challenge = Challenge.new # Needed to instantiate the form_with
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
      @participation = Participation.create(user: current_user, challenge: @challenge)
      # No need for this since I am defining it in the line before
      # @participation.challenge = @challenge
      # @participation.user = current_user
      redirect_to challenge_path(@challenge) # goes to show page
    else
      @challenge.start_date = @challenge.start_date
      @challenge.end_date = @challenge.end_date
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    authorize @challenge
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :goal_qty, :start_date, :end_date, :unit, :type, :price, :card_num, :category)
  end

  def particpation_params
    params.require(:participation).permit(:user_id)
  end
end
