class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :user
      t.references :course
      t.references :promotion
      t.boolean :purchased, default: false
      t.decimal :course_price, precision: 8, scale: 2
      t.datetime :purchase_date

      t.timestamps
    end
    
    add_index :enrollments, :user_id
    add_index :enrollments, :course_id
    add_index :enrollments, :promotion_id
  end
end

