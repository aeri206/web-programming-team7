# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_18_054558) do

  create_table "article_likes", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_article_likes_on_article_id"
    t.index ["profile_id"], name: "index_article_likes_on_profile_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "if_wiki"
    t.boolean "if_sub"
    t.string "sub_title"
    t.integer "chapter"
    t.integer "sub_chapter"
  end

  create_table "companies", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "industry_code"
    t.integer "current_asset"
    t.integer "total_liabilities"
    t.integer "current_liabilities"
    t.integer "fixed_liabilities"
    t.integer "capital"
    t.integer "ebit"
    t.integer "financing_cost"
    t.integer "ci"
    t.integer "ni"
    t.integer "price"
    t.float "ROE"
    t.float "PER"
    t.float "BPS"
    t.float "PBR"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "liabilities"
  end

  create_table "company_likes", force: :cascade do |t|
    t.integer "profile_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_likes_on_company_id"
    t.index ["profile_id"], name: "index_company_likes_on_profile_id"
  end

  create_table "memos", force: :cascade do |t|
    t.text "text"
    t.integer "profile_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_memos_on_article_id"
    t.index ["profile_id"], name: "index_memos_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_likes", "articles"
  add_foreign_key "article_likes", "profiles"
  add_foreign_key "company_likes", "companies"
  add_foreign_key "company_likes", "profiles"
  add_foreign_key "memos", "articles"
  add_foreign_key "memos", "profiles"
  add_foreign_key "profiles", "users"
end
