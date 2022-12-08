# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_07_133010) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cards", force: :cascade do |t|
    t.string "action"
    t.float "value"
    t.bigint "participation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "used", default: false
    t.index ["participation_id"], name: "index_cards_on_participation_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.float "goal_qty"
    t.string "unit"
    t.string "category"
    t.float "challenge_qty"
    t.float "price"
    t.integer "card_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "messages_id"
    t.string "messages"
    t.index ["messages_id"], name: "index_challenges_on_messages_id"
    t.index ["user_id"], name: "index_challenges_on_user_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.string "token"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.integer "invitable_id"
    t.string "invitable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_invites_on_email"
    t.index ["invitable_id", "invitable_type"], name: "index_invites_on_invitable_id_and_invitable_type"
    t.index ["recipient_id"], name: "index_invites_on_recipient_id"
    t.index ["sender_id"], name: "index_invites_on_sender_id"
    t.index ["token"], name: "index_invites_on_token"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "challenge_id", null: false
    t.boolean "stingy", default: false
    t.index ["challenge_id"], name: "index_messages_on_challenge_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "challenge_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_participations_on_challenge_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.text "bio"
    t.boolean "connected_strava"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "token_expires_at", precision: nil
    t.integer "athlete_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_progresses", force: :cascade do |t|
    t.float "progress"
    t.integer "week_num"
    t.float "balance"
    t.bigint "user_id", null: false
    t.bigint "challenge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit"
    t.boolean "updated", default: false
    t.float "week_goal"
    t.float "challenge_goal"
    t.index ["challenge_id"], name: "index_weekly_progresses_on_challenge_id"
    t.index ["user_id"], name: "index_weekly_progresses_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "category"
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "distance"
    t.float "duration"
    t.bigint "activity_id"
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cards", "participations"
  add_foreign_key "challenges", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "participations", "challenges"
  add_foreign_key "participations", "users"
  add_foreign_key "weekly_progresses", "challenges"
  add_foreign_key "weekly_progresses", "users"
  add_foreign_key "workouts", "users"
end
