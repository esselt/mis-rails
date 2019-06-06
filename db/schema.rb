# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161026071829) do

  create_table "jobs", force: :cascade do |t|
    t.string   "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id"

  create_table "matches", force: :cascade do |t|
    t.string   "status",      null: false
    t.integer  "customer_id", null: false
    t.string   "name",        null: false
    t.string   "email",       null: false
    t.string   "title",       null: false
    t.text     "message",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer "upload_id", null: false
    t.integer "job_id", null: false
    t.datetime "sent_at"
    t.string "error"
  end

  add_index "matches", ["job_id"], name: "index_matches_on_job_id"
  add_index "matches", ["status"], name: "index_matches_on_status"
  add_index "matches", ["updated_at"], name: "index_matches_on_updated_at"
  add_index "matches", ["upload_id"], name: "index_matches_on_upload_id"

  create_table "settings", force: :cascade do |t|
    t.integer "version", null: false
    t.string "setting", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["setting"], name: "index_settings_on_setting"

  create_table "uploads", force: :cascade do |t|
    t.string "filename", null: false
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", null: false
    t.integer "combined_id"
    t.integer "job_id"
  end

  add_index "uploads", ["combined_id"], name: "index_uploads_on_combined_id"
  add_index "uploads", ["invoice_id"], name: "index_uploads_on_invoice_id"
  add_index "uploads", ["job_id"], name: "index_uploads_on_job_id"

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
