# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2020_03_17_103635) do
=======
ActiveRecord::Schema.define(version: 2020_03_20_105853) do
>>>>>>> 527c2e470247043c9cf8139e72ebe793167a1ec9

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "user_id"
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "course_contents", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_contents_on_course_id"
    t.index ["section_id"], name: "index_course_contents_on_section_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "section_contents", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_section_contents_on_lesson_id"
    t.index ["section_id"], name: "index_section_contents_on_section_id"
  end

<<<<<<< HEAD
=======
  create_table "sections", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.integer "previous_id"
    t.integer "next_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

>>>>>>> 527c2e470247043c9cf8139e72ebe793167a1ec9
  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "course_contents", "courses"
  add_foreign_key "course_contents", "sections"
  add_foreign_key "section_contents", "lessons"
  add_foreign_key "section_contents", "sections"
end
