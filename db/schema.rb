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

ActiveRecord::Schema.define(:version => 20120121000505) do

  create_table "attachments", :force => true do |t|
    t.string    "title"
    t.text      "description"
    t.string    "file"
    t.integer   "attachable_id"
    t.string    "attachable_type"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "contributors"
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"

  create_table "hostings", :force => true do |t|
    t.integer   "show_id"
    t.integer   "person_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "managers", :force => true do |t|
    t.string    "position"
    t.text      "office_hours"
    t.string    "email"
    t.string    "phone_number"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "person_id"
  end

  create_table "people", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.string    "nickname"
    t.text      "bio"
    t.text      "influences"
    t.string    "facebook_username"
    t.string    "linkedin_username"
    t.string    "twitter_username"
    t.string    "website_url"
    t.string    "email"
    t.string    "major"
    t.string    "class_year"
    t.string    "hometown"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "avatar"
    t.string    "depaul_id"
  end

  create_table "podcasts", :force => true do |t|
    t.string    "title"
    t.text      "description"
    t.string    "podcast_type"
    t.string    "contributors"
    t.string    "file"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "priority"
  end

  create_table "schedulings", :force => true do |t|
    t.integer   "show_id"
    t.integer   "slot_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "shows", :force => true do |t|
    t.string    "title"
    t.string    "genre"
    t.string    "short_description"
    t.text      "long_description"
    t.string    "facebook_page_username"
    t.string    "email"
    t.string    "twitter_username"
    t.string    "website_url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "avatar"
  end

  create_table "slots", :force => true do |t|
    t.string    "quarter"
    t.time      "start_time"
    t.time      "end_time"
    t.boolean   "monday"
    t.boolean   "tuesday"
    t.boolean   "wednesday"
    t.boolean   "thursday"
    t.boolean   "friday"
    t.boolean   "saturday"
    t.boolean   "sunday"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "show_id"
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "password_hash"
    t.string    "password_salt"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "first_name"
    t.string    "last_name"
  end

end
