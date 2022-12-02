class ChangeIntegerLimitInWorkoutsId < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :activity_id, :integer, limit: 8
  end
end
