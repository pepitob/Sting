class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.string :type
      t.string :unit
      t.date :date
      t.float :qty
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
