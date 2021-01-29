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

ActiveRecord::Schema.define(version: 2020_12_16_173343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "donations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", default: true
    t.index ["organization_id"], name: "index_donations_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_donations_on_user_id_and_organization_id"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "fb_url"
    t.string "cause", default: "unknown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location", default: ""
    t.string "avatar_url", default: "default_avatar.png"
    t.boolean "highly_effective", default: false
    t.index ["cause"], name: "index_organizations_on_cause"
    t.index ["fb_url"], name: "index_organizations_on_fb_url", unique: true
    t.index ["location"], name: "index_organizations_on_location"
    t.index ["name"], name: "index_organizations_on_name", unique: true
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "user_favorite_causes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "cause"
    t.string "description"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cause"], name: "index_user_favorite_causes_on_cause"
    t.index ["user_id", "cause"], name: "index_user_favorite_causes_on_user_id_and_cause", unique: true
    t.index ["user_id"], name: "index_user_favorite_causes_on_user_id"
  end

  create_table "user_favorite_organizations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank"
    t.index ["organization_id"], name: "index_user_favorite_organizations_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_user_fav_orgs_on_user_id_and_org_id", unique: true
    t.index ["user_id"], name: "index_user_favorite_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "philosophy"
    t.integer "yearly_income"
    t.boolean "deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "encrypted_password"
    t.string "avatar_url"
    t.string "provider"
    t.string "uid"
    t.string "fb_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["location"], name: "index_users_on_location"
    t.index ["yearly_income"], name: "index_users_on_yearly_income"
  end

  add_foreign_key "donations", "organizations"
  add_foreign_key "donations", "users"
  add_foreign_key "user_favorite_organizations", "organizations"
  add_foreign_key "user_favorite_organizations", "users"
end
