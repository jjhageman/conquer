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

ActiveRecord::Schema.define(:version => 20130529054713) do

  create_table "courses", :force => true do |t|
    t.string   "name",                                                                   :null => false
    t.text     "description"
    t.decimal  "price",                  :precision => 8, :scale => 2,                   :null => false
    t.string   "image"
    t.string   "instructor_name"
    t.text     "instructor_description"
    t.string   "instructor_image"
    t.boolean  "released",                                             :default => true
    t.date     "start_date"
    t.string   "url"
    t.decimal  "rating_average",         :precision => 6, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "promotion_id"
    t.boolean  "purchased",                                   :default => false
    t.decimal  "course_price",  :precision => 8, :scale => 2
    t.datetime "purchase_date"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
  end

  add_index "enrollments", ["course_id"], :name => "index_enrollments_on_course_id"
  add_index "enrollments", ["promotion_id"], :name => "index_enrollments_on_promotion_id"
  add_index "enrollments", ["user_id"], :name => "index_enrollments_on_user_id"

  create_table "promotions", :force => true do |t|
    t.string   "code"
    t.decimal  "price"
    t.string   "video_id"
    t.text     "content"
    t.boolean  "active",     :default => true
    t.integer  "course_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "promotions", ["code"], :name => "index_promotions_on_code", :unique => true
  add_index "promotions", ["course_id"], :name => "index_promotions_on_course_id"

  create_table "ratings", :force => true do |t|
    t.float    "stars",      :null => false
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ratings", ["course_id"], :name => "index_ratings_on_course_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "last_4_digits"
    t.string   "stripe_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
