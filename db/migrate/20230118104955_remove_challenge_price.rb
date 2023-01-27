class RemoveChallengePrice < ActiveRecord::Migration[7.0]
  def change
    remove_column :challenges, :price
  end
end
