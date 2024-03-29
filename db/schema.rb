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

ActiveRecord::Schema[7.0].define(version: 2023_01_11_095628) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_hobbies", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "hobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_hobbies_on_account_id"
    t.index ["hobby_id"], name: "index_account_hobbies_on_hobby_id"
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
    t.bigint "user_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

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

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "author_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.index ["author_comment_id"], name: "index_comments_on_author_comment_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
  end

  create_table "contents", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.bigint "account_id"
    t.index ["account_id"], name: "index_contents_on_account_id"
    t.index ["group_id"], name: "index_contents_on_group_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "f_partner_conversation_id"
    t.bigint "s_partner_conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["f_partner_conversation_id"], name: "index_conversations_on_f_partner_conversation_id"
    t.index ["s_partner_conversation_id"], name: "index_conversations_on_s_partner_conversation_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "f_partner_friendship_id"
    t.bigint "s_partner_friendship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invite_id"
    t.index ["f_partner_friendship_id"], name: "index_friendships_on_f_partner_friendship_id"
    t.index ["invite_id"], name: "index_friendships_on_invite_id"
    t.index ["s_partner_friendship_id"], name: "index_friendships_on_s_partner_friendship_id"
  end

  create_table "group_hobbies", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "hobby_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_hobbies_on_group_id"
    t.index ["hobby_id"], name: "index_group_hobbies_on_hobby_id"
  end

  create_table "group_participants", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_group_participants_on_account_id"
    t.index ["group_id"], name: "index_group_participants_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.text "description"
    t.string "visibility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_creator_id"
    t.string "name_group"
    t.index ["group_creator_id"], name: "index_groups_on_group_creator_id"
  end

  create_table "hobbies", force: :cascade do |t|
    t.string "hobby_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "sender_invite_id"
    t.bigint "receiver_invite_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmed", default: "not"
    t.index ["receiver_invite_id"], name: "index_invites_on_receiver_invite_id"
    t.index ["sender_invite_id"], name: "index_invites_on_sender_invite_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.boolean "readed", default: false
    t.bigint "sender_message_id"
    t.bigint "recipient_message_id"
    t.bigint "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["recipient_message_id"], name: "index_messages_on_recipient_message_id"
    t.index ["sender_message_id"], name: "index_messages_on_sender_message_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.bigint "author_post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_post_id"], name: "index_posts_on_author_post_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "accounts", column: "author_comment_id"
  add_foreign_key "contents", "accounts"
  add_foreign_key "contents", "groups"
  add_foreign_key "conversations", "accounts", column: "f_partner_conversation_id"
  add_foreign_key "conversations", "accounts", column: "s_partner_conversation_id"
  add_foreign_key "friendships", "accounts", column: "f_partner_friendship_id"
  add_foreign_key "friendships", "accounts", column: "s_partner_friendship_id"
  add_foreign_key "friendships", "invites"
  add_foreign_key "groups", "accounts", column: "group_creator_id"
  add_foreign_key "invites", "accounts", column: "receiver_invite_id"
  add_foreign_key "invites", "accounts", column: "sender_invite_id"
  add_foreign_key "messages", "accounts", column: "recipient_message_id"
  add_foreign_key "messages", "accounts", column: "sender_message_id"
  add_foreign_key "posts", "accounts", column: "author_post_id"
end
