class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :code
      t.decimal :price
      t.boolean :active, default: true
      t.references :course

      t.timestamps
    end

    add_index :promotions, :course_id
    add_index :promotions, :code
  end
end
