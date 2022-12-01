class AddDistanceAndTimeToWorkouts < ActiveRecord::Migration[7.0]
  def change
    def change
      add_column :workouts, :distance, :float
      add_column :workouts, :duration, :integer
    end
  end
end
