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

ActiveRecord::Schema.define(version: 20180423111426) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "galleries", force: :cascade do |t|
    t.string "cover_image"
    t.string "title", null: false
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_galleries_on_user_id"
  end

  create_table "galleries_tags", force: :cascade do |t|
    t.bigint "galleries_id", null: false
    t.bigint "tags_id", null: false
    t.index ["galleries_id"], name: "index_galleries_tags_on_galleries_id"
    t.index ["tags_id"], name: "index_galleries_tags_on_tags_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image", null: false
    t.string "description"
    t.string "localization"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gallery_id"
    t.index ["gallery_id"], name: "index_images_on_gallery_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "images_tags", force: :cascade do |t|
    t.bigint "images_id", null: false
    t.bigint "tags_id", null: false
    t.index ["images_id"], name: "index_images_tags_on_images_id"
    t.index ["tags_id"], name: "index_images_tags_on_tags_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false, null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "galleries", "users"
  add_foreign_key "galleries_tags", "galleries", column: "galleries_id"
  add_foreign_key "galleries_tags", "tags", column: "tags_id"
  add_foreign_key "images", "galleries"
  add_foreign_key "images", "users"
  add_foreign_key "images_tags", "images", column: "images_id"
  add_foreign_key "images_tags", "tags", column: "tags_id"
end
