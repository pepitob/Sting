class AddUsedToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :used, :boolean, default: `false`
  end
end
