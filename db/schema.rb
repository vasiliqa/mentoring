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

ActiveRecord::Schema.define(version: 20180901191020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
  end

  create_table "albums", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "priority", default: 2
    t.integer "owner_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_books_on_owner_id"
  end

  create_table "candidate_educations", id: :serial, force: :cascade do |t|
    t.integer "candidate_id"
    t.string "education"
    t.string "specialty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "institution"
    t.index ["candidate_id"], name: "index_candidate_educations_on_candidate_id"
  end

  create_table "candidate_family_members", id: :serial, force: :cascade do |t|
    t.integer "candidate_id"
    t.string "name"
    t.string "gender"
    t.string "age"
    t.string "relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_candidate_family_members_on_candidate_id"
  end

  create_table "candidates", id: :serial, force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "registration_address"
    t.string "home_address"
    t.string "phone_number"
    t.string "email"
    t.date "birth_date"
    t.string "confession"
    t.string "health_status"
    t.string "serious_diseases"
    t.string "organization_name"
    t.string "work_contacts"
    t.string "work_position"
    t.text "hobby"
    t.string "martial_status"
    t.string "program_role"
    t.string "child_age"
    t.string "child_gender"
    t.text "invalid_child"
    t.string "alcohol"
    t.string "tobacco"
    t.string "psychoactive"
    t.string "drugs"
    t.string "child_crime"
    t.string "disabled_parental_rights"
    t.boolean "reports"
    t.boolean "photo_rights"
    t.string "info_about_program"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "state_comment"
    t.boolean "russian_citizenship"
    t.text "family_attitude"
    t.text "visit_hours"
    t.integer "want_new"
    t.integer "plan_be_adoptive_parent"
    t.integer "want_be_significant"
    t.integer "want_get_experience"
    t.integer "want_more_kids"
    t.integer "want_be_in_team"
    t.integer "want_change_job"
    t.integer "pity_kids"
    t.integer "want_pass_experience"
    t.integer "maternal_instinct"
    t.integer "want_increase_status"
    t.text "foreign_child"
    t.text "unsolvable_problems"
    t.text "tragic_events"
    t.text "child_emotions"
    t.text "life_changes"
    t.boolean "week_visits"
    t.boolean "monthly_meeting"
  end

  create_table "children", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.date "birthdate"
    t.integer "orphanage_id"
    t.integer "mentor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["orphanage_id"], name: "index_children_on_orphanage_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "text"
    t.integer "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "mailboxer_conversation_opt_outs", id: :serial, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :serial, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_notifications", id: :serial, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "global", default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :serial, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
  end

  create_table "meetings", id: :serial, force: :cascade do |t|
    t.datetime "date"
    t.string "state"
    t.integer "child_id"
    t.integer "mentor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_meetings_on_child_id"
  end

  create_table "orphanages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "album_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_photos_on_album_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "reports", id: :serial, force: :cascade do |t|
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "feelings"
    t.bigint "mentor_id"
    t.integer "visits_count"
    t.text "description"
    t.integer "difficulties"
    t.text "difficulties_comment"
    t.integer "need_help"
    t.integer "questions"
    t.text "questions_comment"
    t.boolean "share_permission"
    t.index ["mentor_id"], name: "index_reports_on_mentor_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "curator_id"
    t.integer "orphanage_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text "description"
    t.boolean "display_on_site", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["orphanage_id"], name: "index_users_on_orphanage_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  add_foreign_key "albums", "users"
  add_foreign_key "books", "users", column: "owner_id"
  add_foreign_key "children", "orphanages"
  add_foreign_key "comments", "users"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
  add_foreign_key "meetings", "children"
  add_foreign_key "photos", "albums"
  add_foreign_key "photos", "users"
  add_foreign_key "reports", "users", column: "mentor_id"
  add_foreign_key "users", "orphanages"
end
