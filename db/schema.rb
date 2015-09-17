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

ActiveRecord::Schema.define(version: 20150917015602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.integer  "tvdb_actor_id", null: false
    t.integer  "series_id"
    t.string   "name"
    t.string   "image"
    t.string   "role"
    t.integer  "sort_order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "actors", ["name"], name: "index_actors_on_name", using: :btree
  add_index "actors", ["role"], name: "index_actors_on_role", using: :btree
  add_index "actors", ["series_id"], name: "index_actors_on_series_id", using: :btree
  add_index "actors", ["sort_order"], name: "index_actors_on_sort_order", using: :btree
  add_index "actors", ["tvdb_actor_id"], name: "index_actors_on_tvdb_actor_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.integer  "series_id",         null: false
    t.integer  "tvdb_banner_id"
    t.string   "banner_path"
    t.string   "banner_type"
    t.string   "dimensions"
    t.string   "language"
    t.float    "rating"
    t.integer  "rating_count"
    t.string   "thumbnail_path"
    t.string   "vignette_path"
    t.string   "local_banner_path"
    t.string   "season"
    t.binary   "image"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "banners", ["banner_type"], name: "index_banners_on_banner_type", using: :btree
  add_index "banners", ["dimensions"], name: "index_banners_on_dimensions", using: :btree
  add_index "banners", ["language"], name: "index_banners_on_language", using: :btree
  add_index "banners", ["rating"], name: "index_banners_on_rating", using: :btree
  add_index "banners", ["rating_count"], name: "index_banners_on_rating_count", using: :btree
  add_index "banners", ["season"], name: "index_banners_on_season", using: :btree
  add_index "banners", ["series_id"], name: "index_banners_on_series_id", using: :btree
  add_index "banners", ["tvdb_banner_id"], name: "index_banners_on_tvdb_banner_id", using: :btree

  create_table "series", force: :cascade do |t|
    t.integer  "external_id"
    t.string   "language",            default: "en", null: false
    t.string   "name",                               null: false
    t.text     "overview"
    t.datetime "first_aired"
    t.string   "network"
    t.string   "imdb_id"
    t.string   "zap2it_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "banner_info"
    t.string   "air_day_of_week"
    t.string   "air_time"
    t.string   "content_rating"
    t.text     "genres"
    t.float    "rating"
    t.integer  "rating_count"
    t.integer  "runtime"
    t.integer  "tvdb_series_id"
    t.string   "status"
    t.datetime "added"
    t.integer  "added_by"
    t.integer  "tvdb_last_update"
    t.integer  "tvdb_tms_wanted_old"
    t.text     "banner_options"
    t.string   "default_banner"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
