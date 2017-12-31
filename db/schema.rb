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

ActiveRecord::Schema.define(:version => 20171230091013) do

  create_table "calendars", :force => true do |t|
    t.date     "datum"
    t.integer  "wochentage"
    t.integer  "jahr"
    t.integer  "arbeitstag"
    t.decimal  "stunden"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "kaltag"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "client_id"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "project_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "remember_token"
    t.boolean  "admin",              :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "login"
    t.integer  "personnel_number"
    t.integer  "annual_hours"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "works", :force => true do |t|
    t.date     "date"
    t.integer  "week"
    t.string   "day"
    t.time     "start_at"
    t.time     "end_at"
    t.time     "pause"
    t.decimal  "working_hours"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.integer  "client_id"
    t.integer  "task_id"
    t.boolean  "passed"
    t.integer  "year"
    t.integer  "month"
    t.integer  "project_id"
  end

end
