# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_20_033432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name", null: false
    t.date "date_of_birth"
    t.string "email", null: false
    t.string "phone"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "occupation"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entity_type"
    t.boolean "discontinued"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "clients_spouses", id: false, force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "spouse_id", null: false
    t.index ["client_id", "spouse_id"], name: "index_clients_spouses_on_client_id_and_spouse_id"
    t.index ["spouse_id", "client_id"], name: "index_clients_spouses_on_spouse_id_and_client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "image_url"
    t.text "bio"
    t.integer "role"
    t.string "subdomain"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "users"
end
