class Workout < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :date, presence: true
  validates :distance, presence: true
  validates :duration, presence: true

  def self.fetch_workouts
    User.where(connected_strava: true).each do |user|
      @participations = user.participations
      refresh_tokens(user) if DateTime.now() > user.token_expires_at
      user_client = Strava::Api::Client.new(
        access_token: user.access_token
      )
      @activities = user_client.athlete_activities
      @activities.each do |activity|
        if Workout.where(activity_id: activity.id).exists?
        elsif (["Run", "Walk", "Ride", "Swim"].include? activity.type) && (activity.start_date >= user.created_at)
          @workout = Workout.new
          @workout.category = activity.type
          @workout.distance = (activity.distance / 1000.00).round(2)
          @workout.duration = (activity.moving_time / 3600.00).round(2)
          @workout.date = activity.start_date_local
          @workout.user = user
          @workout.activity_id = activity.id
          @workout.save!
          @participations.each do |participation|
            week_num = (((Date.today - participation.challenge.start_date).to_i / 7) + 1)
            @weekly_progress = WeeklyProgress.find_by(user: user, week_num: week_num, challenge: participation.challenge)
            if @weekly_progress.unit == "Km"
              @weekly_progress.progress += @workout.distance
              @weekly_progress.save
              message = Message.new
              workout_text = "🏅 #{@weekly_progress.user.first_name} has completed a workout: #{@workout.distance}km in #{@workout.duration} hours."
              goal_text = "🚩 #{@weekly_progress.user.first_name} reached their weekly goal!"
              @weekly_progress.progress >= participation.challenge.goal_qty ? message.content = workout_text + goal_text : message.content = workout_text
              message.challenge = participation.challenge
              message.user = participation.challenge.user
              message.stingy = true
              message.save!
            elsif @weekly_progress.unit == "Hours"
              @weekly_progress.progress += @workout.duration
              @weekly_progress.save
              message = Message.new
              message.content = "🏅 #{@weekly_progress.user.first_name} has completed a workout! They completed #{@workout.distance}km in #{@workout.duration} hours."
              message.challenge = participation.challenge
              message.user = participation.challenge.user
              message.stingy = true
              message.save!
            end
          end
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
