class CreateForumImages < ActiveRecord::Migration
  def change
    create_table :forum_images do |t|
      t.string :image
      t.references :forum_post

      t.timestamps
    end

    add_index :forum_images, :forum_post_id
  end
end
