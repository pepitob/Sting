class AddActivityIdToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :activity_id, :integer
  end
end
