class ChangeActiveColdefault < ActiveRecord::Migration[7.0]
  def change
    change_column :challenges, :active, :boolean, default: true
  end
end
