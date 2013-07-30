class AddAttributesToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :project_count, :integer
    add_column :courses, :document_count, :integer
  end
end
