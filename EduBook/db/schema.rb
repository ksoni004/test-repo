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

ActiveRecord::Schema.define(version: 20140706123859) do

  create_table "courses", force: true do |t|
    t.integer "teacher_id"
    t.string  "course_name"
  end

  create_table "courses_semesters", id: false, force: true do |t|
    t.integer "course_id"
    t.integer "semester_id"
  end

  create_table "documents", force: true do |t|
    t.integer  "course_id"
    t.integer  "counter",             default: 0
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.integer "teacher_id"
    t.integer "student_id"
    t.integer "ui"
    t.integer "simplicity"
    t.integer "performance"
    t.integer "content_quality"
    t.integer "background"
    t.integer "navigation"
    t.integer "links"
    t.integer "color_choices"
    t.integer "graphics"
    t.integer "spelling_and_grammar"
    t.float   "average"
  end

  create_table "notifications", force: true do |t|
    t.integer  "teacher_id"
    t.string   "semester"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "semesters", force: true do |t|
    t.string   "year"
    t.string   "branch"
    t.string   "semester_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.integer "semester_id"
    t.string  "email"
    t.string  "password"
    t.string  "name"
    t.string  "surname"
  end

  create_table "teachers", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
