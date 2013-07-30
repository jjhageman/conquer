class AddTaglineToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :tagline, :string
    add_column :courses, :hero_image, :string
    add_column :courses, :total_hours, :integer
    add_column :courses, :playlist_id, :string
    add_column :courses, :instructor_title, :string
  end
end
