class CreateWeeklyProgresses < ActiveRecord::Migration[7.0]
  def change
    create_table :weekly_progresses do |t|
      t.float :progress
      t.integer :week_num
      t.float :balance
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
