class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2
      t.string :image
      t.string :instructor_name
      t.text :instructor_description
      t.string :instructor_image

      t.timestamps
    end
  end
end
