class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :stars, :null => false
      t.references :user
      t.references :course

      t.timestamps
    end

    add_index :ratings, :user_id
    add_index :ratings, :course_id
  end
end
