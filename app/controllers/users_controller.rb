class UsersController < ApplicationController

  def show
    create_client
    @user = User.find(params[:id])
    get_user_tokens if params[:code].present?
    authorize @user
    create_redirect_url
    fetch_workouts if @user.connected_strava
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to root_path
  #   # check if root_path is right
  # end

  def create_client
    @client = Strava::OAuth::Client.new(
      client_id: "97779",
      client_secret: ENV["STRAVA_CLIENT_SECRET"]
    )
  end

  def create_redirect_url
    @redirect_url = @client.authorize_url(
      redirect_uri: "http://localhost:3000/users/#{params[:id]}",
      # redirect_uri: "https://www.stingfit.live/users/#{params[:id]}",
      approval_prompt: 'force',
      response_type: 'code',
      scope: 'activity:read_all',
      state: 'magic'
    )
  end

  def get_user_tokens
    code = params[:code]
    response = @client.oauth_token(code: code)
    @user.access_token = response.access_token
    @user.refresh_token = response.refresh_token
    @user.token_expires_at = response.expires_at
    @user.athlete_id = response.athlete.id
    @user.connected_strava = true
    @user.save
  end

  def fetch_workouts
    refresh_tokens if DateTime.now() > @user.token_expires_at
    user_client = Strava::Api::Client.new(
      access_token: @user.access_token
    )
    @activities = user_client.athlete_activities
    @activities.each do |activity|
      if Workout.where(activity_id: activity.id).exists?
      else
        @workout = Workout.new
        @workout.category = activity.type
        @workout.distance = activity.distance
        @workout.duration = activity.moving_time
        @workout.date = activity.start_date_local
        @workout.user = @user
        @workout.activity_id = activity.id
        @workout.save!
      end
    end
  end

  def refresh_tokens
    response = @client.oauth_token(
      refresh_token: @user.refresh_token,
      grant_type: 'refresh_token'
    )
    @user.access_token = response.access_token
    @user.refresh_token = response.refresh_token
    @user.token_expires_at = response.expires_at
    @user.save!
  end
end
