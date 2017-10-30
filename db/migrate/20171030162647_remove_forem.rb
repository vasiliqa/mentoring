class RemoveForem < ActiveRecord::Migration[5.1]
  def change
    drop_table "forem_categories", force: :cascade do |t|
      t.string   "name",                   null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
      t.integer  "position",   default: 0
      t.index ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree
    end

    drop_table "forem_forums", force: :cascade do |t|
      t.string  "name"
      t.text    "description"
      t.integer "category_id"
      t.integer "views_count", default: 0
      t.string  "slug"
      t.integer "position",    default: 0
      t.index ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree
    end

    drop_table "forem_groups", force: :cascade do |t|
      t.string "name"
      t.index ["name"], name: "index_forem_groups_on_name", using: :btree
    end

    drop_table "forem_memberships", force: :cascade do |t|
      t.integer "group_id"
      t.integer "member_id"
      t.index ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree
    end

    drop_table "forem_moderator_groups", force: :cascade do |t|
      t.integer "forum_id"
      t.integer "group_id"
      t.index ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree
    end

    drop_table "forem_posts", force: :cascade do |t|
      t.integer  "topic_id"
      t.text     "text"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "reply_to_id"
      t.string   "state",       default: "pending_review"
      t.boolean  "notified",    default: false
      t.index ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
      t.index ["state"], name: "index_forem_posts_on_state", using: :btree
      t.index ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
      t.index ["user_id"], name: "index_forem_posts_on_user_id", using: :btree
    end

    drop_table "forem_subscriptions", force: :cascade do |t|
      t.integer "subscriber_id"
      t.integer "topic_id"
    end

    drop_table "forem_topics", force: :cascade do |t|
      t.integer  "forum_id"
      t.integer  "user_id"
      t.string   "subject"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "locked",       default: false,            null: false
      t.boolean  "pinned",       default: false
      t.boolean  "hidden",       default: false
      t.datetime "last_post_at"
      t.string   "state",        default: "pending_review"
      t.integer  "views_count",  default: 0
      t.string   "slug"
      t.index ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
      t.index ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
      t.index ["state"], name: "index_forem_topics_on_state", using: :btree
      t.index ["user_id"], name: "index_forem_topics_on_user_id", using: :btree
    end

    drop_table "forem_views", force: :cascade do |t|
      t.integer  "user_id"
      t.integer  "viewable_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "count",             default: 0
      t.string   "viewable_type"
      t.datetime "current_viewed_at"
      t.datetime "past_viewed_at"
      t.index ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
      t.index ["user_id"], name: "index_forem_views_on_user_id", using: :btree
      t.index ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree
    end

    remove_column :users, :forem_admin, :boolean, default: false
    remove_column :users, :forem_state, :string, default: 'pending_review'
    remove_column :users, :forem_auto_subscribe, :boolean, default: false
  end
end
