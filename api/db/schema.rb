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

ActiveRecord::Schema.define(version: 20201025034345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", default: ""
    t.string "picture"
    t.string "tag"
    t.string "time", null: false
    t.string "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "status", default: 0
    t.string "location", default: ""
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "superusers", force: :cascade do |t|
    t.string "login", null: false
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "surname"
    t.string "second_name", default: ""
    t.string "password_digest"
    t.string "email", null: false
    t.string "phone_number", default: ""
    t.string "description", default: ""
    t.string "avatar"
    t.string "role", default: "user"
    t.integer "rank", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "birthday"
    t.string "location"
    t.string "education"
    t.jsonb "achivments", default: {"fin"=>0, "lead"=>0, "family"=>0, "projactiv"=>0, "networking"=>0, "proforient"=>0}
  end

  add_foreign_key "events", "users"
end
