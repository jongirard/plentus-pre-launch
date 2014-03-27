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

ActiveRecord::Schema.define(version: 20140319035859) do

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debts", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.decimal  "interest_annual", precision: 5, scale: 2
    t.integer  "duration"
    t.integer  "present_balance"
    t.integer  "future_value"
    t.integer  "budget_monthly"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "debts", ["user_id"], name: "index_debts_on_user_id"

  create_table "deductions", force: true do |t|
    t.integer  "user_id"
    t.decimal  "home_sqf",            precision: 5, scale: 2
    t.decimal  "business_sqf",        precision: 5, scale: 2
    t.integer  "monthly_expenses"
    t.decimal  "business_kilometers", precision: 5, scale: 2
    t.decimal  "start_kilometers",    precision: 5, scale: 2
    t.integer  "vehicle_expenses"
    t.integer  "short_flight"
    t.integer  "short_meal"
    t.integer  "short_entertainment"
    t.integer  "short_lodging"
    t.integer  "long_flight"
    t.integer  "long_meal"
    t.integer  "long_entertainment"
    t.integer  "long_lodging"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deductions", ["user_id"], name: "index_deductions_on_user_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "expenses", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "amount"
    t.string   "expense_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id"

  create_table "states", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxes", force: true do |t|
    t.integer  "user_id"
    t.integer  "income"
    t.integer  "taxes"
    t.integer  "rrsp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taxes", ["user_id"], name: "index_taxes_on_user_id"

  create_table "users", force: true do |t|
    t.string   "fullname",                            null: false
    t.string   "email",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "income"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
