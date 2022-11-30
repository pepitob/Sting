class ParticipationsController < ApplicationController
  before_action :set_challenge, only: %i[new create]

  def new
    @participation = Participation.new
  end

  def create
    @participation = Participation.new(user: current_user, challenge: @challenge)
    # No need for this since I am defining it in the line before
    # @participation.challenge = @challenge
    # @participation.user = current_user
    if @participation.save
      redirect_to challenge_path(@challenge)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  # def particpation_params
  #   params.require(:participation).permit(:challenge_id)
  # end
end
