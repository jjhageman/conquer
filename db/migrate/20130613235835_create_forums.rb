class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.string :url

      t.timestamps
    end

    add_index :forums, :url
    
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

    add_index :topics, :forum_id
    add_index :topics, :user_id
    add_index :courses, :url

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
      t.integer :count
    end
  end
end
