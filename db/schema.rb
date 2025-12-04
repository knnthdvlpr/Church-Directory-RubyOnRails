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

ActiveRecord::Schema[8.1].define(version: 2025_12_04_063436) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "branch_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_departments_on_branch_id"
  end

  create_table "positions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "department_id", null: false
    t.string "name"
    t.boolean "unique"
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_positions_on_department_id"
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.integer "age", null: false
    t.date "baptismal_date"
    t.string "baptismal_status", default: "Unbaptized"
    t.bigint "branch_id"
    t.datetime "created_at", null: false
    t.bigint "department_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.string "phone_number"
    t.bigint "position_id"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "status", default: "Active"
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["position_id"], name: "index_users_on_position_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "departments", "branches"
  add_foreign_key "positions", "departments"
  add_foreign_key "users", "branches"
  add_foreign_key "users", "departments"
  add_foreign_key "users", "positions"
end
