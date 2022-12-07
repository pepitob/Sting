class AddGoalsColummsWeeklyProgress < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_progresses, :week_goal, :float
    add_column :weekly_progresses, :challenge_goal, :float
  end
end
