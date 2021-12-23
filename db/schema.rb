# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_20_120226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "day_entries", force: :cascade do |t|
    t.text "text"
    t.string "line"
    t.boolean "check"
    t.bigint "day_id"
    t.bigint "diary_entry_id"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_id"], name: "index_day_entries_on_day_id"
    t.index ["diary_entry_id"], name: "index_day_entries_on_diary_entry_id"
  end

  create_table "days", force: :cascade do |t|
    t.datetime "date"
    t.bigint "diary_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_id"], name: "index_days_on_diary_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diary_entries", force: :cascade do |t|
    t.string "title"
    t.integer "sort_order"
    t.string "entry_type"
    t.string "desired_line"
    t.bigint "diary_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diary_id"], name: "index_diary_entries_on_diary_id"
  end

end
