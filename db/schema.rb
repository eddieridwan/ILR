# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110816205831) do

  create_table "line_items", :force => true do |t|
    t.integer  "product_id",                                :null => false
    t.string   "order_id",                                  :null => false
    t.integer  "quantity",                                  :null => false
    t.decimal  "total_price", :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postcode"
    t.string   "country"
    t.string   "email"
    t.string   "shipping_method"
    t.decimal  "shipping_cost",    :precision => 8, :scale => 2
    t.decimal  "tax",              :precision => 8, :scale => 2
    t.decimal  "order_total",      :precision => 8, :scale => 2
    t.boolean  "payment_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "productid"
    t.string   "title"
    t.text     "description"
    t.string   "publisher"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.decimal  "price",            :precision => 8, :scale => 2, :default => 0.0
    t.string   "paypal_button_id"
    t.text     "product_details"
    t.string   "category"
    t.boolean  "in_stock",                                       :default => true
  end

  create_table "resources", :force => true do |t|
    t.string   "title",        :null => false
    t.string   "category"
    t.string   "tags"
    t.text     "summary",      :null => false
    t.text     "description"
    t.string   "url"
    t.string   "organisation"
    t.string   "image"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "status"
    t.string   "type"
    t.string   "submitted_by"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
