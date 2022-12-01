class DeleteQtyFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    remove_column :workouts, :qty, :float
  end
end
