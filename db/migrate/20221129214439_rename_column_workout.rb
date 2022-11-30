class RenameColumnWorkout < ActiveRecord::Migration[7.0]
  def change
    rename_column :workouts, :type, :category
  end
end
