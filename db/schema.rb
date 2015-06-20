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

ActiveRecord::Schema.define(version: 20150620201552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ldaps", force: :cascade do |t|
    t.string   "hostname",           limit: 255,               null: false
    t.integer  "port",                           default: 389, null: false
    t.string   "basedn",             limit: 255,               null: false
    t.string   "filter",             limit: 255
    t.string   "login_mask",         limit: 255,               null: false
    t.string   "username_attribute", limit: 255,               null: false
    t.string   "name_attribute",     limit: 255,               null: false
    t.string   "lastname_attribute", limit: 255,               null: false
    t.string   "email_attribute",    limit: 255,               null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "scripts", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.text     "text"
    t.integer  "lock_version", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                               null: false
    t.string   "lastname",                           null: false
    t.string   "email",                              null: false
    t.string   "password_digest",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token",                         null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "lock_version",           default: 0, null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_reset_token"], name: "index_users_on_password_reset_token", unique: true, using: :btree

end
