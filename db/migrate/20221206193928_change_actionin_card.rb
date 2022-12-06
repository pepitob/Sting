class ChangeActioninCard < ActiveRecord::Migration[7.0]
  def change
    rename_column :cards, :Action, :action
  end
end
