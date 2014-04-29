# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140429054110) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "alerts", force: true do |t|
    t.float    "price_difference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "exchange1"
    t.string   "exchange2"
    t.integer  "frequency"
  end

  create_table "exchanges", force: true do |t|
    t.string   "name"
    t.integer  "nonce"
    t.string   "signature"
    t.string   "apikey"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "alert_id"
  end

  create_table "exchanges_organizations", id: false, force: true do |t|
    t.integer "exchange_id"
    t.integer "organization_id"
  end

  add_index "exchanges_organizations", ["organization_id"], name: "index_exchanges_organizations_on_organization_id"

  create_table "holdings", force: true do |t|
    t.string   "name"
    t.integer  "user_id",    null: false
    t.decimal  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "organization_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_histories", force: true do |t|
    t.decimal  "coinbase"
    t.decimal  "bitstamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "transactions", force: true do |t|
    t.decimal  "btc"
    t.decimal  "usd"
    t.integer  "exchangeid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "order_type"
    t.integer  "exchange_id"
    t.decimal  "balance"
  end

  add_index "transactions", ["exchange_id"], name: "index_transactions_on_exchange_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "organization_id"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["organization_id"], name: "index_users_on_organization_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
