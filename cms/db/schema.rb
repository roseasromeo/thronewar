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

ActiveRecord::Schema.define(version: 20151223020523) do

  create_table "auctions", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "phase",      default: 0,     null: false
    t.boolean  "closed",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "auctions", ["game_id"], name: "index_auctions_on_game_id"

  create_table "char_rounds", force: :cascade do |t|
    t.integer  "character_id", null: false
    t.integer  "round_id",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "char_rounds", ["character_id"], name: "index_char_rounds_on_character_id"
  add_index "char_rounds", ["round_id"], name: "index_char_rounds_on_round_id"

  create_table "characters", force: :cascade do |t|
    t.string   "pseudonym",                null: false
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "points_spent", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "characters", ["game_id"], name: "index_characters_on_game_id"
  add_index "characters", ["user_id"], name: "index_characters_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "rules_page_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "comments", ["rules_page_id"], name: "index_comments_on_rules_page_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "games", force: :cascade do |t|
    t.string   "title",                  null: false
    t.integer  "status",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "items", force: :cascade do |t|
    t.boolean  "closed",      default: false
    t.integer  "num_strikes", default: 0,     null: false
    t.integer  "name",        default: 0,     null: false
    t.integer  "auction_id",                  null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "items", ["auction_id"], name: "index_items_on_auction_id"

  create_table "pledges", force: :cascade do |t|
    t.integer  "rank",          default: 0, null: false
    t.integer  "character_id",              null: false
    t.integer  "char_round_id",             null: false
    t.integer  "item_id",                   null: false
    t.integer  "value",                     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "pledges", ["char_round_id"], name: "index_pledges_on_char_round_id"
  add_index "pledges", ["character_id"], name: "index_pledges_on_character_id"
  add_index "pledges", ["item_id"], name: "index_pledges_on_item_id"

  create_table "rounds", force: :cascade do |t|
    t.integer  "auction_id"
    t.integer  "number",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "rounds", ["auction_id"], name: "index_rounds_on_auction_id"

  create_table "rules_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "slug",       default: "1"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "subpages", force: :cascade do |t|
    t.string   "subtitle"
    t.text     "sidebar"
    t.text     "body"
    t.integer  "order_number",  null: false
    t.integer  "rules_page_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subpages", ["rules_page_id"], name: "index_subpages_on_rules_page_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                       null: false
    t.string   "name",                        null: false
    t.string   "password_digest",             null: false
    t.integer  "user_type",       default: 2, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
