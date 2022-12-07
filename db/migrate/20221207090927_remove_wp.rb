class RemoveWp < ActiveRecord::Migration[7.0]
  def change
    remove_column :cards, :weekly_progress_id
  end
end
