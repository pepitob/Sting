class CardsController < ApplicationController
  def apply_card
    @card = Card.find(params[:id])
    authorize @card
    @card.used = true
    @card.save!

    @challenge = Challenge.find(params[:challenge_id])
    @week = @challenge.current_week
    @weekly_progress = WeeklyProgress.find_by(challenge: @challenge, week_num: @week, user_id: params[:user_id])
    @weekly_progress.week_goal += (@weekly_progress.week_goal * @card.value)
    @weekly_progress.save!
    redirect_to challenge_path(@challenge)
  end
end
