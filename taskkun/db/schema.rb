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

ActiveRecord::Schema.define(version: 2021_06_28_064108) do

  create_table "deleted_tasks", charset: "utf8mb4", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.text "description", size: :tiny
    t.integer "importance", null: false
    t.date "due_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status_id"
  end

  create_table "labels", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statuses", charset: "utf8mb4", force: :cascade do |t|
    t.text "name", size: :tiny, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", charset: "utf8mb4", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.text "description", size: :tiny
    t.integer "importance", null: false
    t.date "due_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status_id"
    t.index ["status_id"], name: "index_tasks_on_status_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
