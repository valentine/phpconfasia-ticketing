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

ActiveRecord::Schema.define(version: 20180408144712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "attendees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "id_number"
    t.string   "email"
    t.string   "twitter"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "size"
    t.string   "github"
    t.string   "cutting"
    t.string   "public_id",  default: "NA", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "daily_start_time"
    t.string   "daily_end_time"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "contact_email"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "ticket_type_id"
    t.integer  "quantity"
    t.integer  "total_amount_cents"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "purchase_order_id"
  end

  add_index "orders", ["purchase_order_id"], name: "index_orders_on_purchase_order_id", using: :btree
  add_index "orders", ["ticket_type_id"], name: "index_orders_on_ticket_type_id", using: :btree

  create_table "purchase_orders", force: :cascade do |t|
    t.integer  "total_amount_cents"
    t.datetime "purchased_at"
    t.string   "ip"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.text     "notes"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_token"
    t.text     "payer_address"
    t.string   "payer_email"
    t.string   "payer_salutation"
    t.string   "payer_first_name"
    t.string   "payer_last_name"
    t.string   "payer_country"
    t.text     "raw_payment_details"
    t.string   "invoice_no"
    t.integer  "event_id"
  end

  add_index "purchase_orders", ["event_id"], name: "index_purchase_orders_on_event_id", using: :btree

  create_table "ticket_types", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "strikethrough_price",         precision: 10, scale: 2
    t.decimal  "price",                       precision: 10, scale: 2
    t.integer  "quota"
    t.boolean  "hidden"
    t.string   "code"
    t.boolean  "active"
    t.datetime "sale_starts_at"
    t.datetime "sale_ends_at"
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.integer  "sequence",                                             default: 0,     null: false
    t.boolean  "complimentary"
    t.boolean  "needs_document"
    t.string   "currency_unit",                                        default: "SGD"
    t.boolean  "standalone",                                           default: false
    t.integer  "entitlement",                                          default: 1
    t.boolean  "restrict_quantity_per_order"
    t.integer  "quantity_per_order",                                   default: 0
  end

  add_index "ticket_types", ["event_id"], name: "index_ticket_types_on_event_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "attendee_id"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "document"
  end

  add_index "tickets", ["attendee_id"], name: "index_tickets_on_attendee_id", using: :btree
  add_index "tickets", ["order_id"], name: "index_tickets_on_order_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "orders", "purchase_orders"
  add_foreign_key "orders", "ticket_types"
  add_foreign_key "purchase_orders", "events"
  add_foreign_key "ticket_types", "events"
  add_foreign_key "tickets", "attendees"
  add_foreign_key "tickets", "orders"
end
