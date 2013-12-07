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

ActiveRecord::Schema.define(version: 20131207052038) do

  create_table "completed_quests", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "quest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "quest_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["quest_id"], name: "index_images_on_quest_id"

  create_table "quests", force: true do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "name"
    t.string   "address"
    t.string   "hint"
    t.text     "brief"
    t.integer  "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place_name"
    t.string   "phone"
    t.text     "fun_facts"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "facebookId"
    t.string   "imageURL"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exp"
  end

end
