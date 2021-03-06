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

ActiveRecord::Schema.define(version: 2020_08_21_233206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip_code", null: false
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "date_of_birth"
    t.string "email", null: false
    t.string "phone"
    t.string "occupation"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "entity_type", default: 0, null: false
    t.boolean "discontinued", default: false
    t.text "notes"
    t.bigint "spouse_id"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_clients_on_address_id"
    t.index ["spouse_id"], name: "index_clients_on_spouse_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id", null: false
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_companies_on_address_id"
    t.index ["client_id"], name: "index_companies_on_client_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.integer "job_type", default: 0, null: false
    t.float "price", default: 0.0
    t.boolean "paid_in_full", default: false, null: false
    t.text "notes"
    t.date "due_date"
    t.integer "status", default: 0, null: false
    t.bigint "client_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_jobs_on_client_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", null: false
    t.integer "payment_type"
    t.integer "check_number"
    t.text "notes"
    t.boolean "partial_payment", default: false
    t.bigint "job_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_payments_on_job_id"
  end

  create_table "tax_returns", force: :cascade do |t|
    t.integer "fed_form", null: false
    t.integer "tax_year", null: false
    t.string "primary_state"
    t.string "other_states"
    t.boolean "printed", default: false
    t.boolean "scanned", default: false
    t.boolean "uploaded", default: false
    t.date "filed"
    t.date "ack_fed"
    t.date "ack_primary_state"
    t.date "ack_other_states"
    t.boolean "rejected", default: false
    t.text "notes"
    t.bigint "job_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_tax_returns_on_job_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
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

  add_foreign_key "clients", "addresses"
  add_foreign_key "clients", "clients", column: "spouse_id"
  add_foreign_key "clients", "users"
  add_foreign_key "companies", "addresses"
  add_foreign_key "companies", "clients"
  add_foreign_key "jobs", "clients"
  add_foreign_key "jobs", "users"
  add_foreign_key "payments", "jobs"
  add_foreign_key "tax_returns", "jobs"
end
