class ParticipationsController < ApplicationController
  before_action :set_challenge, only: %i[new create]

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

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def participation_params
    params.require(:participation).permit(:challenge_id, :user_id)
  end
end
