class AddActiveToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :released, :boolean, :default => true
  end
end
