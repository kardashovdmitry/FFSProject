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

ActiveRecord::Schema.define(version: 20160507112340) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "description_for_measurement_groups", primary_key: "DescriptionForMeasurementGroupID", force: :cascade do |t|
    t.string  "name",    limit: 100, null: false
    t.string  "value",   limit: 300
    t.integer "groupID"
  end

  add_index "description_for_measurement_groups", ["name"], name: "name_measur_group", using: :btree

  create_table "description_for_rd", primary_key: "DescriptionForRdID", force: :cascade do |t|
    t.string  "name",  limit: 50,  null: false
    t.string  "value", limit: 300
    t.integer "rdID"
  end

  add_index "description_for_rd", ["name"], name: "name_rp", using: :btree

  create_table "devices", primary_key: "deviceID", force: :cascade do |t|
    t.string "name",         limit: 100, null: false
    t.string "manufacturer", limit: 50
    t.text   "description"
    t.string "model",        limit: 200
  end

  add_index "devices", ["name"], name: "name", using: :btree

  create_table "linkeds", id: false, force: :cascade do |t|
    t.integer "measurementID", null: false
    t.integer "groupID",       null: false
  end

  create_table "measurement_description_for_measurements", primary_key: "DescriptionForMeasurementID", force: :cascade do |t|
    t.string  "name",          limit: 100, null: false
    t.string  "value",         limit: 300
    t.integer "measurementID"
  end

  add_index "measurement_description_for_measurements", ["name"], name: "name_measur", using: :btree

  create_table "measurement_groups", primary_key: "groupID", force: :cascade do |t|
    t.integer "sampleID"
    t.integer "researcherID"
    t.integer "deviceID"
    t.string  "name",         limit: 100, null: false
    t.date    "date",                     null: false
  end

  add_index "measurement_groups", ["date"], name: "date", using: :btree
  add_index "measurement_groups", ["name"], name: "name_measurement", using: :btree

  create_table "measurements", primary_key: "measurementID", force: :cascade do |t|
    t.string  "fileName", limit: 200, null: false
    t.integer "count",                null: false
    t.float   "binTime"
    t.float   "T"
    t.float   "C",                    null: false
    t.float   "n"
    t.integer "rpID"
    t.text    "x"
    t.text    "y"
    t.text    "z"
    t.text    "std"
  end

  add_index "measurements", ["C"], name: "C", using: :btree
  add_index "measurements", ["T"], name: "T", using: :btree
  add_index "measurements", ["binTime"], name: "count", using: :btree
  add_index "measurements", ["count", "binTime"], name: "double_index", using: :btree
  add_index "measurements", ["fileName"], name: "fileName", using: :btree
  add_index "measurements", ["n"], name: "n", using: :btree

  create_table "raw_data", primary_key: "rdID", force: :cascade do |t|
    t.integer "groupID",                      null: false
    t.string  "name",             limit: 100, null: false
    t.string  "FileName",         limit: 200
    t.string  "linkToFile",       limit: 500
    t.integer "startTime"
    t.integer "repetitionNumber"
    t.integer "kineticsNumber"
    t.text    "description"
  end

  add_index "raw_data", ["FileName"], name: "FileName", using: :btree
  add_index "raw_data", ["name"], name: "name_rd", using: :btree

  create_table "researchers", primary_key: "researcherID", force: :cascade do |t|
    t.string  "name",          limit: 100, null: false
    t.integer "phone"
    t.string  "organizations", limit: 100
    t.string  "address",       limit: 300
    t.string  "email",         limit: 100
  end

  add_index "researchers", ["email"], name: "Researcher_email_key", unique: true, using: :btree
  add_index "researchers", ["name"], name: "index_name", using: :btree
  add_index "researchers", ["organizations"], name: "organization", using: :btree

  create_table "samples", primary_key: "sampleID", force: :cascade do |t|
    t.string  "name",        limit: 100, null: false
    t.float   "weight"
    t.integer "size"
    t.float   "M"
    t.float   "lambda_em"
    t.float   "lambda_ex"
    t.text    "description"
  end

  add_index "samples", ["name"], name: "name_sample", using: :btree
  add_index "samples", ["size"], name: "size", using: :btree
  add_index "samples", ["weight"], name: "weight", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "description_for_measurement_groups", "measurement_groups", column: "groupID", primary_key: "groupID", name: "Ref_DescriptionForMeasurementGroup_to_MeasurementGroup"
  add_foreign_key "description_for_rd", "raw_data", column: "rdID", primary_key: "rdID", name: "Ref_DescriptionForRD_to_RawData"
  add_foreign_key "linkeds", "measurement_groups", column: "groupID", primary_key: "groupID", name: "Ref_Linked_to_MeasurementGroup"
  add_foreign_key "linkeds", "measurements", column: "measurementID", primary_key: "measurementID", name: "Ref_Linked_to_Measurement"
  add_foreign_key "measurement_description_for_measurements", "measurements", column: "measurementID", primary_key: "measurementID", name: "Ref_MeasurementDescriptionForMeasurement_to_Measurement"
  add_foreign_key "measurement_groups", "devices", column: "deviceID", primary_key: "deviceID", name: "Ref_MeasurementGroup_to_Device"
  add_foreign_key "measurement_groups", "researchers", column: "researcherID", primary_key: "researcherID", name: "Ref_MeasurementGroup_to_Researcher"
  add_foreign_key "measurement_groups", "samples", column: "sampleID", primary_key: "sampleID", name: "Ref_MeasurementGroup_to_Sample"
  add_foreign_key "measurements", "raw_data", column: "rpID", primary_key: "rdID", name: "Measurement_fk"
  add_foreign_key "raw_data", "measurement_groups", column: "groupID", primary_key: "groupID", name: "Ref_RP_to_MeasurementGroup"
end
