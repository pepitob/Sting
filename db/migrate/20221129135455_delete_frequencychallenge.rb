class DeleteFrequencychallenge < ActiveRecord::Migration[7.0]
  def change
    remove_column :challenges, :frequency
  end
end
