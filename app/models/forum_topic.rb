class ForumTopic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many   :posts, dependent: :destroy, order: "forum_posts.created_at ASC"

  accepts_nested_attributes_for :posts

  validates :subject, :presence => true
  validates :user, :presence => true

  acts_as_url :subject
  
  attr_accessible :hidden, :last_post_at, :locked, :pinned, :subject, :url, :view_count
end
