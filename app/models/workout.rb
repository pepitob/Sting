class Workout < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :date, presence: true
  validates :distance, presence: true
  validates :duration, presence: true

  def self.fetch_workouts
    User.where(connected_strava: true).each do |user|
      refresh_tokens(user) if DateTime.now() > user.token_expires_at
      user_client = Strava::Api::Client.new(
        access_token: user.access_token
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
          @workout.user = user
          @workout.activity_id = activity.id
          @workout.save!
        end
      end
    end
  end

  def refresh_tokens(user)
    client = Strava::OAuth::Client.new(
      client_id: "97779",
      client_secret: ENV["STRAVA_CLIENT_SECRET"]
    )
    response = client.oauth_token(
      refresh_token: user.refresh_token,
      grant_type: 'refresh_token'
    )
    user.access_token = response.access_token
    user.refresh_token = response.refresh_token
    user.token_expires_at = response.expires_at
    user.save!
  end
end
