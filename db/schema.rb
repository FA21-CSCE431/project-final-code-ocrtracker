# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_26_211952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exercise_posts", force: :cascade do |t|
    t.bigint "exercise_id"
    t.bigint "workout_post_id"
    t.text "specific_instructions"
    t.boolean "is_ranked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_exercise_posts_on_exercise_id"
    t.index ["workout_post_id"], name: "index_exercise_posts_on_workout_post_id"
  end

  create_table "exercise_submissions", force: :cascade do |t|
    t.bigint "exercise_post_id"
    t.bigint "workout_submission_id"
    t.string "unit_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "opt_out"
    t.bigint "user_id"
    t.index ["exercise_post_id"], name: "index_exercise_submissions_on_exercise_post_id"
    t.index ["user_id"], name: "index_exercise_submissions_on_user_id"
    t.index ["workout_submission_id"], name: "index_exercise_submissions_on_workout_submission_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.text "picture"
    t.text "unit_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archived", default: false
  end

  create_table "fistbumps", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "exercise_submission_id"
    t.index ["exercise_submission_id"], name: "index_fistbumps_on_exercise_submission_id"
    t.index ["user_id"], name: "index_fistbumps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.boolean "is_admin"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archived", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workout_posts", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "wod_date"
    t.boolean "archived", default: false
  end

  create_table "workout_submissions", force: :cascade do |t|
    t.bigint "workout_post_id"
    t.bigint "user_id"
    t.datetime "submitted_datetime"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "archived", default: false
    t.index ["user_id"], name: "index_workout_submissions_on_user_id"
    t.index ["workout_post_id"], name: "index_workout_submissions_on_workout_post_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "exercise_posts", "exercises"
  add_foreign_key "exercise_posts", "workout_posts"
  add_foreign_key "exercise_submissions", "exercise_posts"
  add_foreign_key "exercise_submissions", "users"
  add_foreign_key "exercise_submissions", "workout_submissions"
  add_foreign_key "fistbumps", "exercise_submissions"
  add_foreign_key "fistbumps", "users"
  add_foreign_key "workout_submissions", "users"
  add_foreign_key "workout_submissions", "workout_posts"
end
