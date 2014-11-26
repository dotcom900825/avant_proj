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

ActiveRecord::Schema.define(version: 20141126044329) do

  create_table "avant_data", force: true do |t|
    t.string   "subject_identification"
    t.string   "sequence_id"
    t.string   "primary_study_id"
    t.string   "aeidrp_id"
    t.string   "primary_study"
    t.string   "other_id"
    t.string   "enrollment_date"
    t.string   "seqpresent"
    t.integer  "sdtj_01_deg"
    t.integer  "sdtj_015_deg"
    t.integer  "lanl_01_deg"
    t.integer  "lanl_015_deg"
    t.integer  "sdtj_01"
    t.integer  "sdtj_015"
    t.integer  "lanl_01"
    t.integer  "lanl_015"
    t.string   "name"
    t.date     "interview_time"
    t.integer  "baseline_age"
    t.integer  "question_duration"
    t.integer  "gender"
    t.string   "race"
    t.integer  "marital_status"
    t.integer  "sexual_orientation"
    t.string   "rfhiv"
    t.integer  "idu"
    t.integer  "blood_trans"
    t.integer  "sharp_exposure"
    t.string   "sex_prostitutes"
    t.string   "transaction_sex_loc"
    t.string   "transaction_sex_type_loc"
    t.string   "idu_loc_use"
    t.string   "idu_loc_use_type"
    t.string   "acute_hiv"
    t.string   "first_pos_hiv"
    t.string   "cd4dx"
    t.string   "hivvldx"
    t.string   "locdx"
    t.string   "edi"
    t.string   "edicat"
    t.string   "cd4_curr"
    t.string   "hiv_vlcurr"
    t.string   "date_curr"
    t.integer  "std_last_year"
    t.string   "residence_country"
    t.string   "residence_city"
    t.string   "residence_state"
    t.string   "born_country"
    t.string   "born_state"
    t.string   "born_city"
    t.integer  "citizenship"
    t.integer  "education"
    t.string   "ethnicity"
    t.integer  "deported"
    t.string   "monthly_income"
    t.string   "language"
    t.text     "address"
    t.string   "zip"
    t.integer  "occupation"
    t.integer  "informal_occ"
    t.string   "loc_occ"
    t.integer  "border_xing"
    t.integer  "gc"
    t.integer  "hcv"
    t.integer  "on_art"
    t.string   "on_art_date"
    t.string   "art_pie"
    t.string   "art_nnrti"
    t.integer  "gonorrhea"
    t.integer  "chlamydia"
    t.integer  "syphilis"
    t.integer  "hepatitis_c"
    t.integer  "human_papillomavirus"
    t.integer  "heroin"
    t.integer  "meth"
    t.integer  "alcohol_consumption"
    t.integer  "sharing_needle"
    t.integer  "transactional_sex"
    t.integer  "partner_number"
    t.integer  "recent_institution"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password",                null: false
    t.string   "salt",                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
