class ChangeActiveColdefault < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :active, :boolean, default: true
  end
end
