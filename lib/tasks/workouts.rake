namespace :workouts do
  desc "TODO"
  task fetch: :environment do
    Workout.fetch_workouts
  end
end
