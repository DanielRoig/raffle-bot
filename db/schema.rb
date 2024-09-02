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

ActiveRecord::Schema[7.0].define(version: 2024_09_03_084339) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string "telegram_id"
    t.string "imageable_type", null: false
    t.bigint "imageable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable"
  end

  create_table "numbers", force: :cascade do |t|
    t.bigint "raffle_id", null: false
    t.integer "value", null: false
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raffle_id", "value"], name: "index_numbers_on_raffle_id_and_value", unique: true
    t.index ["raffle_id"], name: "index_numbers_on_raffle_id"
    t.index ["user_id"], name: "index_numbers_on_user_id"
  end

  create_table "raffles", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.integer "first_number", null: false
    t.integer "last_number", null: false
    t.integer "price", null: false
    t.string "payment_info", null: false
    t.integer "status", default: 0
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "telegram_id", null: false
    t.string "telegram_first_name", null: false
    t.string "telegram_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["telegram_id"], name: "index_users_on_telegram_id", unique: true
  end

  add_foreign_key "numbers", "raffles"
  add_foreign_key "numbers", "users"
end
