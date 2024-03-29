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

ActiveRecord::Schema.define(:version => 20130807041834) do

  create_table "alternatives", :force => true do |t|
    t.string   "which"
    t.integer  "participants", :default => 0
    t.integer  "conversions",  :default => 0
    t.text     "experiment"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "alternatives", ["which"], :name => "index_alternatives_on_which"

  create_table "chapters", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image"
    t.string   "video_id"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "chapters", ["course_id"], :name => "index_chapters_on_course_id"

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
    t.string   "tagline"
    t.string   "hero_image"
    t.integer  "total_hours"
    t.string   "playlist_id"
    t.string   "instructor_title"
    t.integer  "project_count"
    t.integer  "document_count"
    t.text     "additional_description"
    t.string   "video_image"
  end

  add_index "courses", ["url"], :name => "index_courses_on_url"

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

  create_table "forum_images", :force => true do |t|
    t.string   "image"
    t.integer  "forum_post_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "forum_images", ["forum_post_id"], :name => "index_forum_images_on_forum_post_id"

  create_table "forum_posts", :force => true do |t|
    t.text     "text"
    t.integer  "replied_to_id"
    t.integer  "user_id"
    t.integer  "forum_topic_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "forum_posts", ["forum_topic_id"], :name => "index_forum_posts_on_forum_topic_id"
  add_index "forum_posts", ["replied_to_id"], :name => "index_forum_posts_on_replied_to_id"
  add_index "forum_posts", ["user_id"], :name => "index_forum_posts_on_user_id"

  create_table "forum_topics", :force => true do |t|
    t.string   "subject"
    t.boolean  "locked",             :default => false
    t.boolean  "pinned",             :default => false
    t.boolean  "hidden",             :default => false
    t.datetime "last_post_at"
    t.integer  "views_count",        :default => 0
    t.string   "url"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "instructor_replied"
  end

  add_index "forum_topics", ["forum_id"], :name => "index_forum_topics_on_forum_id"
  add_index "forum_topics", ["url"], :name => "index_forum_topics_on_url"
  add_index "forum_topics", ["user_id"], :name => "index_forum_topics_on_user_id"

  create_table "forum_views", :force => true do |t|
    t.integer  "count",             :default => 0
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "forum_views", ["updated_at"], :name => "index_forum_views_on_updated_at"
  add_index "forum_views", ["user_id"], :name => "index_forum_views_on_user_id"
  add_index "forum_views", ["viewable_id"], :name => "index_forum_views_on_viewable_id"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "forums", ["course_id"], :name => "index_forums_on_course_id"
  add_index "forums", ["url"], :name => "index_forums_on_url"

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
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
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
    t.boolean  "admin",                  :default => false, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
