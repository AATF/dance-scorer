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

ActiveRecord::Schema[8.1].define(version: 2026_10_15_003000) do
  create_table "dancers", id: { type: :string, limit: 36 }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "dance_name", null: false
    t.integer "performance_order", default: 1, null: false
    t.string "group_id", limit: 36, null: false
    t.index ["group_id"], name: "fk_rails_051c369b06"
  end

  create_table "groups", id: { type: :string, limit: 36 }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "scores", id: { type: :string, limit: 36 }, charset: "utf8mb3", force: :cascade do |t|
    t.float "theme", null: false
    t.float "choreography", null: false
    t.float "technique", null: false
    t.float "presentation", null: false
    t.float "costume", null: false
    t.float "music", null: false
    t.float "violation", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.float "total", null: false
    t.string "dancer_id", limit: 36, null: false
    t.string "user_id", limit: 36, null: false
    t.index ["dancer_id"], name: "fk_rails_5b03197483"
    t.index ["total"], name: "index_scores_on_total"
    t.index ["user_id"], name: "fk_rails_f5dcd5d06f"
  end

  create_table "settings", id: { type: :string, limit: 36 }, charset: "utf8mb3", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["var"], name: "index_settings_on_var", unique: true
  end

  create_table "users", id: { type: :string, limit: 36 }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "password_digest", null: false
    t.string "username", null: false
    t.boolean "admin", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "dancers", "groups"
  add_foreign_key "scores", "dancers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "scores", "users", on_update: :cascade, on_delete: :cascade
end
