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

ActiveRecord::Schema.define(version: 20140818141905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: true do |t|
    t.string  "name"
    t.text    "contact_information"
    t.string  "status"
    t.integer "desirable_salary"
  end

  add_index "applicants", ["id"], name: "index_applicants_on_id", using: :btree

  create_table "applicants_skills", id: false, force: true do |t|
    t.integer "applicant_id"
    t.integer "skill_id"
  end

  add_index "applicants_skills", ["applicant_id"], name: "index_applicants_skills_on_applicant_id", using: :btree
  add_index "applicants_skills", ["skill_id"], name: "index_applicants_skills_on_skill_id", using: :btree

  create_table "skills", force: true do |t|
    t.string "name"
  end

  add_index "skills", ["id"], name: "index_skills_on_id", using: :btree

  create_table "skills_vacancies", id: false, force: true do |t|
    t.integer "skill_id"
    t.integer "vacancy_id"
  end

  add_index "skills_vacancies", ["skill_id"], name: "index_skills_vacancies_on_skill_id", using: :btree
  add_index "skills_vacancies", ["vacancy_id"], name: "index_skills_vacancies_on_vacancy_id", using: :btree

  create_table "vacancies", force: true do |t|
    t.string   "name"
    t.integer  "validity_period"
    t.integer  "salary"
    t.text     "contact_information"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vacancies", ["id"], name: "index_vacancies_on_id", using: :btree

end
