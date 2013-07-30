class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :video_id
      t.references :course

      t.timestamps
    end

    add_index :chapters, :course_id
  end
end
