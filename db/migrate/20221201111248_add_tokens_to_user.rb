class AddTokensToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :connected_strava, :boolean
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :token_expires_at, :date
    add_column :users, :athlete_id, :integer
  end
end
