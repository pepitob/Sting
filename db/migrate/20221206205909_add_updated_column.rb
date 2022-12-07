class AddUpdatedColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_progresses, :updated, :boolean, default: false
  end
end
