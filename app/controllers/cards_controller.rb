class CardsController < ApplicationController
  def apply_card
    @card = Card.find(params[:id])
    authorize @card
    @card.used = true
    @card.save!

    @challenge = Challenge.find(params[:challenge_id])
    @week = @challenge.current_week
    @weekly_progress = WeeklyProgress.find_by(challenge: @challenge, week_num: @week, user_id: params[:user_id])
    ## Notification
    message = Message.new
    sender = current_user.first_name
    current_user == User.find(params[:user_id]) ? recipient = "themself" : recipient = User.find(params[:user_id]).first_name
    @card.value > 0 ? stingy_says = "That sucks!" : stingy_says = "Lucky them!"
    @card.value > 0 ? verb = "stung" : verb = "spared"
    @card.value > 0 ? change_word = "more" : change_word = "less"
    message.content = "🃏 #{sender} #{verb} #{recipient}. #{User.find(params[:user_id]).first_name} now has to complete #{(@weekly_progress.week_goal * @card.value).abs} #{@weekly_progress.unit.downcase} #{change_word} to reach their weekly goal. #{stingy_says}"
    message.challenge = @challenge
    message.user = current_user
    message.stingy = true
    message.save!
    ## End of Notification
    @weekly_progress.week_goal += (@weekly_progress.week_goal * @card.value)
    @weekly_progress.save!
    redirect_to challenge_path(@challenge)
  end
end
