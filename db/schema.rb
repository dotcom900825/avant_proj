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

ActiveRecord::Schema.define(version: 20150512160811) do

  create_table "AEH_Roster", primary_key: "pid", force: true do |t|
  end

  create_table "Bio", primary_key: "pid", force: true do |t|
    t.date    "collect_date"
    t.text    "aliases"
    t.date    "birth_date"
    t.string  "first_name",     limit: 100
    t.string  "last_name",      limit: 100
    t.string  "middle_initial", limit: 5
    t.string  "suffix",         limit: 10
    t.integer "not_done"
  end

  create_table "Contact", primary_key: "pid", force: true do |t|
    t.date    "collect_date"
    t.string  "city",                limit: 100
    t.string  "email1",              limit: 100
    t.string  "email2",              limit: 100
    t.string  "phone1",              limit: 25
    t.integer "phone1_secure"
    t.string  "phone2",              limit: 25
    t.integer "phone2_secure"
    t.integer "phonetype1"
    t.integer "phonetype2"
    t.string  "state_province",      limit: 100
    t.string  "street_address_1",    limit: 100
    t.string  "street_address_2",    limit: 100
    t.integer "study_opportunities"
    t.integer "testing_reminder"
    t.string  "zip_code",            limit: 10
    t.integer "not_done"
  end

  create_table "ET_AEH_Map", id: false, force: true do |t|
    t.string "RedCrossID", limit: 10, default: "", null: false
    t.string "pid",        limit: 6,  default: "", null: false
  end

  add_index "et_aeh_map", ["pid"], name: "pid", using: :btree

  create_table "ET_DetunedEIA", primary_key: "RedCrossID", force: true do |t|
    t.date    "collect_date"
    t.float   "result",       limit: 53
    t.integer "test_kit"
    t.integer "test_source"
    t.integer "not_done"
  end

  create_table "ET_NAT", primary_key: "RedCrossID", force: true do |t|
    t.integer "hbv_result"
    t.integer "hcv_result"
    t.integer "hiv_result"
    t.integer "nat_result"
    t.integer "not_done"
  end

  create_table "ET_RapidTest", primary_key: "RedCrossID", force: true do |t|
    t.date    "collect_date"
    t.string  "comments",        limit: 45
    t.integer "rapid2"
    t.integer "rapid2_test_kit"
    t.integer "result"
    t.integer "test_kit"
    t.integer "test_source"
    t.integer "not_done"
  end

  create_table "ET_Roster", primary_key: "RedCrossID", force: true do |t|
  end

  create_table "PHI", id: false, force: true do |t|
    t.string "tableName", limit: 45, default: "", null: false
    t.string "fieldName", limit: 45, default: "", null: false
  end

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
    t.date     "enrollment_time"
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
    t.string   "lat"
    t.string   "long"
  end

  create_table "sdtj_demos", force: true do |t|
    t.string   "pid"
    t.string   "x"
    t.string   "sequence_id"
    t.string   "primary_study"
    t.string   "aehpid"
    t.string   "sequence_date"
    t.string   "aeh"
    t.string   "edi_class"
    t.string   "edi_date"
    t.string   "zip"
    t.string   "date_of_sequence"
    t.date     "date_of_enrollment"
    t.string   "race"
    t.string   "ethnicity"
    t.string   "marital_status"
    t.string   "age"
    t.string   "sex"
    t.string   "sexual_orientation"
    t.string   "risk_factor_hiv"
    t.string   "inject_drug"
    t.string   "blood_transfusion"
    t.string   "sharps_exposure"
    t.string   "transactional_sex"
    t.string   "sex_with_prostitutes"
    t.string   "number_of_partners"
    t.string   "heroin_usage"
    t.string   "meth_usage"
    t.string   "alcohol_consumption"
    t.string   "recent_institutionalization"
    t.string   "first_hiv_test"
    t.string   "estimated_date_of_infection"
    t.string   "category_of_edi"
    t.string   "current_cd4_count"
    t.string   "current_hiv_load"
    t.string   "date_of_current_lab_values"
    t.string   "std_history_within_last_year"
    t.string   "syphilis"
    t.string   "gonorrhea"
    t.string   "chlamydia"
    t.string   "hcv"
    t.string   "location_of_residence_at_time_of_interview"
    t.string   "loc_res_city"
    t.string   "state"
    t.string   "country"
    t.string   "border_cross_last_year"
    t.string   "birth_nation"
    t.string   "birth_state"
    t.string   "birth_city"
    t.string   "deported"
    t.string   "cur_vl_log"
    t.string   "cluster_id"
    t.string   "mean_path_length"
    t.string   "relative_to_cluster_min"
    t.string   "degree"
    t.string   "betweenness_centrality"
    t.string   "clustering_binary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lat"
    t.string   "long"
  end

  create_table "ticino_data", force: true do |t|
    t.integer  "subject_id"
    t.string   "site_subject"
    t.string   "site_name"
    t.date     "interview_date"
    t.integer  "age"
    t.integer  "question_duration"
    t.string   "gender"
    t.string   "marital_status"
    t.string   "sexual_orientation"
    t.string   "country_of_residence"
    t.string   "city_of_residence"
    t.string   "country_of_birth"
    t.string   "city_of_birth"
    t.string   "citizenship"
    t.integer  "education_in_years"
    t.string   "ethnicity"
    t.string   "previously_deported"
    t.string   "monthly_income"
    t.string   "languages"
    t.string   "height"
    t.string   "gonorrhea_diagnosis"
    t.string   "chlamydia_diagnosis"
    t.string   "syphilis_diagnosis"
    t.string   "hepatitis_c_diagnosis"
    t.string   "human_papillomavirus_diagnosis"
    t.string   "heroin_usage"
    t.string   "methamphetamine_usage"
    t.string   "alcohol_consumption"
    t.string   "sharing_needles"
    t.string   "transactional_sex"
    t.string   "number_of_sexual_partners"
    t.string   "first_hiv_pos_date"
    t.string   "currently_on_art"
    t.string   "art_begin_date"
    t.string   "hivvl_curr"
    t.string   "cd4_curr"
    t.string   "edi_date"
    t.string   "edi_cat"
    t.string   "temperature"
    t.string   "oral_ulceration"
    t.string   "pharyngitis"
    t.string   "thrush"
    t.string   "inguinal"
    t.string   "hepatomegaly"
    t.string   "rash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                       null: false
    t.string   "crypted_password",                            null: false
    t.string   "salt",                                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "username"
    t.integer  "phi_role",                        default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "visualization_paths", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "filter"
    t.text     "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wifi_data", force: true do |t|
    t.float   "time",        limit: 24
    t.string  "source"
    t.string  "destination"
    t.string  "protocol"
    t.integer "length"
    t.text    "info"
  end

end
