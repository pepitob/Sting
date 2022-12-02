class UpdateWorkoutsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Workout.fetch_workouts
  end
end
