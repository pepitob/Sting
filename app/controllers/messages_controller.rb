class MessagesController < ApplicationController
  before_action :skip_authorization

  def create
    @user = current_user
    @challenge = Challenge.find(params[:challenge_id])
    @message = Message.new(message_params)
    @message.challenge = @challenge
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to challenge_path(@challenge) }
        format.json
      else
        render "challenges/show", status: :unprocessable_entity
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
