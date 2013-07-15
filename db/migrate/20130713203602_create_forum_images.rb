class CreateForumImages < ActiveRecord::Migration
  def change
    create_table :forum_images do |t|
      t.string :image
      t.references :forum_gallery

      t.timestamps
    end

    create_table :forum_galleries do |t|
      t.references :forum_post

      t.timestamps
    end

    add_index :forum_images, :forum_gallery_id
    add_index :forum_galleries, :forum_post_id
  end
end
