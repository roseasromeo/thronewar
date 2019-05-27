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

ActiveRecord::Schema.define(version: 2019_05_27_162908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.string "short_text"
    t.string "long_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ability_char_trees", force: :cascade do |t|
    t.bigint "char_tree_id"
    t.bigint "ability_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_ability_char_trees_on_ability_id"
    t.index ["char_tree_id"], name: "index_ability_char_trees_on_char_tree_id"
  end

  create_table "ability_dependencies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.bigint "depends_on_id"
    t.index ["depends_on_id"], name: "index_ability_dependencies_on_depends_on_id"
    t.index ["parent_id"], name: "index_ability_dependencies_on_parent_id"
  end

  create_table "auctions", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.integer "phase", default: 0, null: false
    t.boolean "closed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_auctions_on_game_id"
  end

  create_table "char_rounds", id: :serial, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_char_rounds_on_character_id"
    t.index ["round_id"], name: "index_char_rounds_on_round_id"
  end

  create_table "char_trees", force: :cascade do |t|
    t.bigint "final_character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["final_character_id"], name: "index_char_trees_on_final_character_id"
  end

  create_table "character_systems", id: :serial, force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "title", null: false
    t.integer "status", default: 0, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_character_systems_on_game_id"
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "pseudonym", null: false
    t.integer "user_id"
    t.integer "game_id"
    t.integer "points_spent", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_characters_on_game_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.integer "rules_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rules_page_id"], name: "index_comments_on_rules_page_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "content_links", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "link", null: false
    t.integer "order", default: 0, null: false
    t.integer "level", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "link_index_id", null: false
    t.index ["link_index_id"], name: "index_content_links_on_link_index_id"
  end

  create_table "final_characters", id: :serial, force: :cascade do |t|
    t.integer "character_system_id", null: false
    t.integer "user_id", null: false
    t.integer "flaw1"
    t.integer "flaw2"
    t.string "name"
    t.text "blurb"
    t.text "background"
    t.text "backstory_connections"
    t.text "goal"
    t.text "curses"
    t.text "standard_form"
    t.text "wishes"
    t.text "flesh_forms"
    t.text "other"
    t.integer "luck", default: 0
    t.integer "approval", default: 0, null: false
    t.integer "leftover_points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "extra_wishes", default: 0
    t.index ["character_system_id"], name: "index_final_characters_on_character_system_id"
    t.index ["user_id"], name: "index_final_characters_on_user_id"
  end

  create_table "flaws", id: :serial, force: :cascade do |t|
    t.integer "character_system_id"
    t.string "name", null: false
    t.text "description"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_system_id"], name: "index_flaws_on_character_system_id"
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.boolean "closed", default: false
    t.integer "num_strikes", default: 0, null: false
    t.integer "name", default: 0, null: false
    t.integer "auction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_items_on_auction_id"
  end

  create_table "link_indices", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pledges", id: :serial, force: :cascade do |t|
    t.integer "rank", default: 0, null: false
    t.integer "character_id", null: false
    t.integer "char_round_id", null: false
    t.integer "item_id", null: false
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["char_round_id"], name: "index_pledges_on_char_round_id"
    t.index ["character_id"], name: "index_pledges_on_character_id"
    t.index ["item_id"], name: "index_pledges_on_item_id"
  end

  create_table "ranks", id: :serial, force: :cascade do |t|
    t.integer "final_character_id"
    t.integer "item", null: false
    t.integer "public_points", default: 0
    t.integer "private_points", default: 0
    t.integer "public_rank", default: 0
    t.integer "private_rank", default: 0
    t.boolean "half", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["final_character_id"], name: "index_ranks_on_final_character_id"
  end

  create_table "regencies", id: :serial, force: :cascade do |t|
    t.integer "final_character_id"
    t.string "name"
    t.text "description"
    t.text "abilities", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points", default: 0
    t.text "keeper_abilities", default: [], array: true
    t.index ["final_character_id"], name: "index_regencies_on_final_character_id"
  end

  create_table "rounds", id: :serial, force: :cascade do |t|
    t.integer "auction_id"
    t.integer "number", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auction_id"], name: "index_rounds_on_auction_id"
  end

  create_table "rules_pages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug", default: "1"
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subpages", id: :serial, force: :cascade do |t|
    t.string "subtitle"
    t.text "sidebar"
    t.text "body"
    t.integer "order_number", null: false
    t.integer "rules_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rules_page_id"], name: "index_subpages_on_rules_page_id"
  end

  create_table "tools", id: :serial, force: :cascade do |t|
    t.integer "final_character_id", null: false
    t.string "name"
    t.integer "points", default: 0
    t.text "abilities", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["final_character_id"], name: "index_tools_on_final_character_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.integer "user_type", default: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "ability_char_trees", "abilities"
  add_foreign_key "ability_char_trees", "char_trees"
  add_foreign_key "ability_dependencies", "abilities", column: "depends_on_id"
  add_foreign_key "ability_dependencies", "abilities", column: "parent_id"
  add_foreign_key "auctions", "games"
  add_foreign_key "char_rounds", "characters"
  add_foreign_key "char_rounds", "rounds"
  add_foreign_key "char_trees", "final_characters"
  add_foreign_key "character_systems", "games"
  add_foreign_key "characters", "games"
  add_foreign_key "characters", "users"
  add_foreign_key "comments", "rules_pages"
  add_foreign_key "comments", "users"
  add_foreign_key "final_characters", "character_systems"
  add_foreign_key "final_characters", "flaws", column: "flaw1"
  add_foreign_key "final_characters", "flaws", column: "flaw2"
  add_foreign_key "final_characters", "users"
  add_foreign_key "flaws", "character_systems"
  add_foreign_key "items", "auctions"
  add_foreign_key "pledges", "char_rounds"
  add_foreign_key "pledges", "characters"
  add_foreign_key "pledges", "items"
  add_foreign_key "ranks", "final_characters"
  add_foreign_key "regencies", "final_characters"
  add_foreign_key "rounds", "auctions"
  add_foreign_key "subpages", "rules_pages"
  add_foreign_key "tools", "final_characters"
end
