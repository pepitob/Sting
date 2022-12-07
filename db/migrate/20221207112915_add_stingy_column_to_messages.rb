class AddStingyColumnToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :stingy, :boolean, default: false
  end
end
