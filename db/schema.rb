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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130224110156) do

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "languages_users", :force => true do |t|
    t.integer "user_id"
    t.integer "language_id"
  end

  create_table "learn_skills", :force => true do |t|
    t.integer  "skill_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "meetings", :force => true do |t|
    t.datetime "time"
    t.string   "opentok_session_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "mentor_id"
    t.integer  "mentee_id"
    t.integer  "translator_id"
    t.string   "titanpad_id"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teach_skills", :force => true do |t|
    t.integer  "skill_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "time_slots", :force => true do |t|
    t.datetime "time"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "user_id"
    t.boolean  "taken",      :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "fb_uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "image"
    t.string   "location"
    t.integer  "timezone"
    t.string   "bio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
