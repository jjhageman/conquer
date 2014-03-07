class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :image
      t.string :instructor_name
      t.text :instructor_description
      t.string :instructor_image
      t.boolean :released, default: true
      t.date :start_date
      t.string :url
      t.decimal :rating_average, default: 0, precision: 6, scale: 2

      t.timestamps
    end

    add_index :courses, :url
  end
end
