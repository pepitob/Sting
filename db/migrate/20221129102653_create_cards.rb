class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :Action
      t.float :value
      t.references :participation, null: false, foreign_key: true
      t.references :weekly_progress, null: false, foreign_key: true

      t.timestamps
    end
  end
end
