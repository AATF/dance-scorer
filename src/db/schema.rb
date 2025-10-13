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

ActiveRecord::Schema[8.0].define(version: 2018_02_03_224131) do
  create_table "dancers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "group_id", null: false
    t.string "dance_name", null: false
    t.integer "performance_order", default: 1, null: false
    t.index ["group_id"], name: "fk_rails_051c369b06"
  end

  create_table "groups", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "scores", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "theme", null: false
    t.float "choreography", null: false
    t.float "technique", null: false
    t.float "presentation", null: false
    t.float "costume", null: false
    t.float "music", null: false
    t.float "violation", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "dancer_id", null: false
    t.integer "user_id", null: false
    t.float "total", null: false
    t.index ["dancer_id"], name: "fk_rails_5b03197483"
    t.index ["total"], name: "index_scores_on_total"
    t.index ["user_id"], name: "fk_rails_f5dcd5d06f"
  end

  create_table "settings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "password_digest", null: false
    t.string "username", null: false
    t.boolean "admin", null: false
    t.index ["name"], name: "index_users_on_name"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "dancers", "groups"
  add_foreign_key "scores", "dancers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "scores", "users", on_update: :cascade, on_delete: :cascade
end
