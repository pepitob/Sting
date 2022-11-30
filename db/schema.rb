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

ActiveRecord::Schema[7.0].define(version: 2022_11_29_175732) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "Action"
    t.float "value"
    t.bigint "participation_id", null: false
    t.bigint "weekly_progress_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "used"
    t.index ["participation_id"], name: "index_cards_on_participation_id"
    t.index ["weekly_progress_id"], name: "index_cards_on_weekly_progress_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.float "goal_qty"
    t.string "unit"
    t.string "type"
    t.float "challenge_qty"
    t.float "price"
    t.integer "card_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["challenge_id"], name: "index_weekly_progresses_on_challenge_id"
    t.index ["user_id"], name: "index_weekly_progresses_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "type"
    t.string "unit"
    t.date "date"
    t.float "qty"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "cards", "participations"
  add_foreign_key "cards", "weekly_progresses"
  add_foreign_key "participations", "challenges"
  add_foreign_key "participations", "users"
  add_foreign_key "weekly_progresses", "challenges"
  add_foreign_key "weekly_progresses", "users"
  add_foreign_key "workouts", "users"
end
