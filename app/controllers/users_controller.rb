class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize @user
    create_redirect_url
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to root_path
  #   # check if root_path is right
  # end
  def create_redirect_url
    client = Strava::OAuth::Client.new(
      client_id: "97779",
      client_secret: ENV["STRAVA_CLIENT_SECRET"]
    )

    @redirect_url = client.authorize_url(
      redirect_uri: 'http://localhost:3000/users/2',
      approval_prompt: 'force',
      response_type: 'code',
      scope: 'activity:read_all',
      state: 'magic'
    )
  end

  def get_user_tokens
    response = client.oauth_token(code: '5b898e8874fbb1f98ef2f470159a4033eb1738d7')
  end
end
