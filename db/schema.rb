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

ActiveRecord::Schema.define(version: 20161001152924) do

  create_table "channel_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_permissions_on_channel_id", using: :btree
    t.index ["user_id"], name: "index_channel_permissions_on_user_id", using: :btree
  end

  create_table "channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "server_id"
    t.string   "name"
    t.boolean  "active",     default: true, null: false
    t.boolean  "boolean",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
    t.index ["name"], name: "index_channels_on_name", unique: true, using: :btree
  end

  create_table "log_stats", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "channel_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["channel_id", "date"], name: "index_log_stats_on_channel_id_and_date", unique: true, using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "channel_id"
    t.string   "text",       limit: 512
    t.string   "user",       limit: 20,  null: false
    t.string   "command"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["channel_id", "created_at"], name: "index_messages_on_channel_id_and_created_at", using: :btree
    t.index ["channel_id"], name: "index_messages_on_channel_id", using: :btree
    t.index ["created_at"], name: "index_messages_on_created_at", using: :btree
    t.index ["text"], name: "index_messages_on_text", type: :fulltext
  end

  create_table "servers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "host"
    t.string   "encoding"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                               null: false
    t.boolean  "admin",                  default: false, null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
