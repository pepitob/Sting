class ChallengesController < ApplicationController
  def index
    @challenges = policy_scope(Challenge) # returns a Challenge.all
    @challenges = @challenges.select { |challenge| challenge.participations.any? {|participation| participation.user == current_user}}
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
    @challenge = Challenge.find(params[:id])
    authorize @challenge
    # I can add participants in the show view
    @participation = Participation.new
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :goal_qty, :start_date, :end_date, :unit, :price, :card_num, :category)
  end

  def participation_params
    params.require(:participation).permit(:user_id)
  end
end
