class AddInstructorRepliedToForumTopics < ActiveRecord::Migration
  def change
    add_column :forum_topics, :instructor_replied, :boolean
  end
end
