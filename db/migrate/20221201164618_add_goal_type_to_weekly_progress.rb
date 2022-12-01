class AddGoalTypeToWeeklyProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_progresses, :unit, :string
  end
end
