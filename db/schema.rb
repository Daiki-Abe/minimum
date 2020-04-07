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

ActiveRecord::Schema.define(version: 2020_04_07_015658) do

  create_table "buy_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "buy_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_id"], name: "index_buy_tags_on_buy_id"
    t.index ["tag_id"], name: "index_buy_tags_on_tag_id"
  end

  create_table "buys", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "goods", null: false
    t.string "price", null: false
    t.string "image"
    t.text "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_buys_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.bigint "user_id"
    t.bigint "buy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_id"], name: "index_comments_on_buy_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dump_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.bigint "user_id"
    t.bigint "dump_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dump_id"], name: "index_dump_comments_on_dump_id"
    t.index ["user_id"], name: "index_dump_comments_on_user_id"
  end

  create_table "dump_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "dump_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dump_id"], name: "index_dump_tags_on_dump_id"
    t.index ["tag_id"], name: "index_dump_tags_on_tag_id"
  end

  create_table "dumps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "goods", null: false
    t.string "price", null: false
    t.string "image"
    t.text "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_dumps_on_user_id"
  end

  create_table "hates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "buy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buy_id"], name: "index_hates_on_buy_id"
    t.index ["user_id"], name: "index_hates_on_user_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buy_tags", "buys"
  add_foreign_key "buy_tags", "tags"
  add_foreign_key "buys", "users"
  add_foreign_key "comments", "buys"
  add_foreign_key "comments", "users"
  add_foreign_key "dump_comments", "dumps"
  add_foreign_key "dump_comments", "users"
  add_foreign_key "dump_tags", "dumps"
  add_foreign_key "dump_tags", "tags"
  add_foreign_key "dumps", "users"
  add_foreign_key "hates", "buys"
  add_foreign_key "hates", "users"
end
