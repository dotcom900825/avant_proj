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

ActiveRecord::Schema.define(version: 20141022164251) do

  create_table "avant_data", force: true do |t|
    t.string   "subject_identification"
    t.string   "name"
    t.date     "interview_time"
    t.integer  "baseline_age"
    t.integer  "question_duration"
    t.integer  "gender"
    t.integer  "martial_status"
    t.integer  "sexual_orientation"
    t.string   "residence_country"
    t.string   "residence_city"
    t.string   "born_country"
    t.string   "born_city"
    t.integer  "citizenship"
    t.integer  "education"
    t.string   "ethnicity"
    t.integer  "deported"
    t.string   "monthly_income"
    t.string   "language"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
