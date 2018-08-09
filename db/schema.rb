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

ActiveRecord::Schema.define(version: 20180809195213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "search_notebooks", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_queries", force: :cascade do |t|
    t.string   "query_string", null: false
    t.integer  "hits",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "search_results", force: :cascade do |t|
    t.string   "login_name",         null: false
    t.integer  "karma",              null: false
    t.string   "url",                null: false
    t.integer  "search_query_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "search_notebook_id"
    t.index ["search_notebook_id"], name: "index_search_results_on_search_notebook_id", using: :btree
    t.index ["search_query_id"], name: "index_search_results_on_search_query_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "search_result_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["search_result_id"], name: "index_taggings_on_search_result_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "search_results", "search_notebooks"
  add_foreign_key "search_results", "search_queries"
  add_foreign_key "taggings", "search_results"
  add_foreign_key "taggings", "tags"
end
