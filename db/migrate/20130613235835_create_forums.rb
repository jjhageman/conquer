class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.string :url
      t.references :course

      t.timestamps
    end

    add_index :forums, :url
    add_index :forums, :course_id

    create_table :forum_topics do |t|
      t.string :subject
      t.boolean :locked, default: false
      t.boolean :pinned, default: false
      t.boolean :hidden, default: false
      t.datetime :last_post_at
      t.integer :views_count, default: 0
      t.string :url
      t.references :forum
      t.references :user

      t.timestamps
    end

    add_index :forum_topics, :forum_id
    add_index :forum_topics, :user_id
    add_index :forum_topics, :url

    create_table :forum_posts do |t|
      t.text :text
      t.integer :replied_to_id
      t.references :user
      t.references :forum_topic

      t.timestamps
    end

    add_index :forum_posts, :replied_to_id
    add_index :forum_posts, :user_id
    add_index :forum_posts, :forum_topic_id

    create_table :forum_views do |t|
      t.integer :count, default: 0
      t.integer :viewable_id
      t.string :viewable_type
      t.datetime :current_viewed_at
      t.datetime :past_viewed_at
      t.references :user

      t.timestamps
    end

    add_index :forum_views, :user_id
    add_index :forum_views, :viewable_id
    add_index :forum_views, :updated_at
  end
end
