class ChangeUnitsToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :workouts, :duration, :float
  end
end
