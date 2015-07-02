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

ActiveRecord::Schema.define(version: 20150614045254) do

  create_table "accounts", force: true do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "proxy",         default: "50.2.15.102"
  end

  create_table "accounts_tweets", force: true do |t|
    t.integer  "account_id"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "posted"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "auto_follows", force: true do |t|
    t.integer  "account_id"
    t.integer  "follower_id"
    t.boolean  "followed"
    t.boolean  "follow_back"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inactive_user"
  end

  add_index "auto_follows", ["account_id"], name: "account_index", using: :btree
  add_index "auto_follows", ["followed", "inactive_user"], name: "next_user_index", using: :btree
  add_index "auto_follows", ["follower_id"], name: "follower_index", using: :btree

  create_table "celebrities", force: true do |t|
    t.string   "uid"
    t.string   "handle"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "followers", force: true do |t|
    t.string   "uid"
    t.integer  "celebrity_id"
    t.string   "handle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.text     "status"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
