class AddUserReferencetoChallenge < ActiveRecord::Migration[7.0]
  change_table(:challenges) do |t|
    t.references :user, null: false, foreign_key: true
  end
end
