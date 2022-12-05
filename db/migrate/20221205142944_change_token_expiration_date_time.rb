class ChangeTokenExpirationDateTime < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :token_expires_at, :datetime
  end
end
