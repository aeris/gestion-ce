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

ActiveRecord::Schema.define(version: 20130831140601) do

  create_table "accounts", force: true do |t|
    t.string   "name",       null: false
    t.string   "tag",        null: false
    t.string   "number",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["tag"], name: "index_accounts_on_tag", unique: true

  create_table "activities", force: true do |t|
    t.string   "description", null: false
    t.date     "date",        null: false
    t.float    "plan_debit",  null: false
    t.float    "plan_credit", null: false
    t.boolean  "closed",      null: false
    t.integer  "agency_id"
    t.integer  "year_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["agency_id"], name: "index_activities_on_agency_id"
  add_index "activities", ["year_id"], name: "index_activities_on_year_id"

  create_table "agencies", force: true do |t|
    t.string   "name",       null: false
    t.string   "tag",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agencies", ["tag"], name: "index_agencies_on_tag", unique: true

  create_table "budgets", force: true do |t|
    t.float    "residual",   null: false
    t.integer  "year_id",    null: false
    t.integer  "account_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budgets", ["account_id"], name: "index_budgets_on_account_id"
  add_index "budgets", ["year_id", "account_id"], name: "index_budgets_on_year_id_and_account_id", unique: true
  add_index "budgets", ["year_id"], name: "index_budgets_on_year_id"

  create_table "entries", force: true do |t|
    t.date     "date",        null: false
    t.string   "to",          null: false
    t.string   "description"
    t.float    "amount",      null: false
    t.string   "category",    null: false
    t.string   "state",       null: false
    t.string   "bank"
    t.string   "number"
    t.integer  "budget_id"
    t.integer  "agency_id"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["activity_id"], name: "index_entries_on_activity_id"
  add_index "entries", ["agency_id"], name: "index_entries_on_agency_id"
  add_index "entries", ["budget_id"], name: "index_entries_on_budget_id"

  create_table "payments", force: true do |t|
    t.date     "date"
    t.float    "amount"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["budget_id"], name: "index_payments_on_budget_id"

  create_table "staffs", force: true do |t|
    t.integer  "number"
    t.integer  "agency_id"
    t.integer  "year_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staffs", ["agency_id", "year_id"], name: "index_staffs_on_agency_id_and_year_id", unique: true
  add_index "staffs", ["agency_id"], name: "index_staffs_on_agency_id"
  add_index "staffs", ["year_id"], name: "index_staffs_on_year_id"

  create_table "users", force: true do |t|
    t.string   "name",       null: false
    t.string   "surname",    null: false
    t.string   "login",      null: false
    t.string   "password",   null: false
    t.integer  "agency_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["agency_id"], name: "index_users_on_agency_id"
  add_index "users", ["login"], name: "index_users_on_login", unique: true

  create_table "years", force: true do |t|
    t.integer  "year",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "years", ["year"], name: "index_years_on_year", unique: true

end
