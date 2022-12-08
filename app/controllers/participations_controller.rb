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
      redirect_to challenge_path(@challenge)
      flash[:success] = "You have join the group!"
    else
      flash.now[:error] = "Something went wrong. Are you in the group already ?"
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
end
