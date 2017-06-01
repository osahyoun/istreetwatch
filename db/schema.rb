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

ActiveRecord::Schema.define(version: 20170601114829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pledges", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "reports", force: :cascade do |t|
    t.decimal  "lat",                  precision: 10, scale: 6
    t.decimal  "lng",                  precision: 10, scale: 6
    t.datetime "date"
    t.string   "address"
    t.string   "street"
    t.string   "house"
    t.string   "town"
    t.text     "description"
    t.boolean  "approved",                                      default: false
    t.string   "postcode"
    t.string   "country"
    t.string   "region"
    t.string   "informant_email"
    t.string   "informant_name"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "support"
    t.string   "informant_tel"
    t.boolean  "informant_permission"
    t.string   "informant_role"
    t.string   "type_incident_other"
    t.string   "type_location"
    t.string   "type_location_other"
    t.string   "reported_to_police"
    t.time     "approved_at"
    t.string   "type_incident",                                                              array: true
    t.string   "source"
    t.boolean  "informant_is_student"
    t.string   "verification_code"
    t.datetime "verified_at"
  end

end
