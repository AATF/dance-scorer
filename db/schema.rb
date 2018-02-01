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

ActiveRecord::Schema.define(version: 20180201033612) do

  create_table "dancers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id",   null: false
    t.string   "dance_name", null: false
    t.index ["group_id"], name: "fk_rails_051c369b06", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", using: :btree
  end

  create_table "scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "theme",        null: false
    t.integer  "choreography", null: false
    t.integer  "technique",    null: false
    t.integer  "presentation", null: false
    t.integer  "costume",      null: false
    t.integer  "music",        null: false
    t.integer  "violation",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "dancer_id",    null: false
    t.integer  "user_id",      null: false
    t.integer  "total",        null: false
    t.index ["dancer_id"], name: "fk_rails_5b03197483", using: :btree
    t.index ["total"], name: "index_scores_on_total", using: :btree
    t.index ["user_id"], name: "fk_rails_f5dcd5d06f", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest", null: false
    t.string   "username",        null: false
    t.index ["name"], name: "index_users_on_name", using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "dancers", "groups"
  add_foreign_key "scores", "dancers", on_update: :cascade, on_delete: :cascade
  add_foreign_key "scores", "users", on_update: :cascade, on_delete: :cascade
end
