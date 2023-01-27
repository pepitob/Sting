class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :state
      t.string :checkout_session_id
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
