class DeleteUnitFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    remove_column :workouts, :unit, :string
  end
end
