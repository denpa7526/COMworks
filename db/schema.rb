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

ActiveRecord::Schema[7.0].define(version: 2024_10_23_052457) do
  create_table "admin_users", charset: "utf8mb3", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "phone_number", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_admin_users_on_company_id"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["user_id"], name: "index_admin_users_on_user_id"
  end

  create_table "companies", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "rooms", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "room_type", null: false
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_rooms_on_created_by_id"
  end

  create_table "shared_passwords", charset: "utf8mb3", force: :cascade do |t|
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.boolean "initial", default: false, null: false
    t.index ["company_id"], name: "index_shared_passwords_on_company_id"
    t.index ["password_digest"], name: "index_shared_passwords_on_password_digest", unique: true
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "username", null: false
    t.string "position", null: false
    t.string "phone_number", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "admin_users", "companies"
  add_foreign_key "admin_users", "users"
  add_foreign_key "rooms", "users", column: "created_by_id"
  add_foreign_key "shared_passwords", "companies"
  add_foreign_key "users", "companies"
end
