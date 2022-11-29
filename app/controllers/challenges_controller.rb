class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new # Needed to instantiate the form_with
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      redirect_to challenge_path(@challenge)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.require(:challenge).permit(:name, :goal_qty, :start_date, :end_date, :unit, :challenge_qty, :type, :price, :card_num)
  end
end
