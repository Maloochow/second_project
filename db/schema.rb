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

ActiveRecord::Schema.define(version: 20200726233112) do

  create_table "client_gallery_statuses", force: :cascade do |t|
    t.integer "client_id"
    t.integer "gallery_id"
    t.boolean "status"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.integer  "admin_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "previews", force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "client_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string   "artwork"
    t.date     "starting_date"
    t.date     "ending_date"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  create_table "user_invites", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "new_user_email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "status"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "intro"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "gallery_id"
  end

end
