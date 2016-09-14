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

ActiveRecord::Schema.define(version: 20160914134700) do

  create_table "channels", force: :cascade do |t|
    t.integer  "server_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                 default: true, null: false
    t.string   "key",        limit: 255
  end

  add_index "channels", ["name"], name: "index_channels_on_name", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "channel_id", limit: 4
    t.string   "text",       limit: 512
    t.string   "user",       limit: 20,  null: false
    t.string   "command",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["channel_id", "created_at"], name: "index_messages_on_channel_id_and_created_at", using: :btree
  add_index "messages", ["channel_id"], name: "index_messages_on_channel_id", using: :btree
  add_index "messages", ["created_at"], name: "index_messages_on_created_at", using: :btree
  add_index "messages", ["text"], name: "index_messages_on_text", type: :fulltext

  create_table "servers", force: :cascade do |t|
    t.string   "host",       limit: 255
    t.string   "encoding",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255,              null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
