class ChangeUsedCardColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :cards, :used, :boolean, default: false
  end
end
