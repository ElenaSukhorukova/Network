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

ActiveRecord::Schema[7.0].define(version: 2022_11_20_121943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_interests", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "interest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_interests_on_account_id"
    t.index ["interest_id"], name: "index_account_interests_on_interest_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "user_name"
    t.string "gender"
    t.date "date_birthday"
    t.text "about_oneself"
    t.string "country"
    t.string "visibility"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests", force: :cascade do |t|
    t.string "name_interest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
