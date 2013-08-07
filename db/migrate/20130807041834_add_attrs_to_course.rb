class AddAttrsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :additional_description, :text
    add_column :courses, :video_image, :string
  end
end
