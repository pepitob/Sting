class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :frequency
      t.date :start_date
      t.date :end_date
      t.float :goal_qty
      t.string :unit
      t.string :type
      t.float :challenge_qty
      t.float :price
      t.integer :card_num

      t.timestamps
    end
  end
end
