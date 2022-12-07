class AddMessageChallenge2 < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :messages, :string
  end
end
