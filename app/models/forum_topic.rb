class ForumTopic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many   :posts, class_name: 'ForumPost', dependent: :destroy, order: "forum_posts.created_at ASC"

  accepts_nested_attributes_for :posts

  validates :subject, :presence => true
  validates :user, :presence => true

  acts_as_url :subject
  
  attr_accessible :hidden, :last_post_at, :locked, :pinned, :subject, :url, :views_count, :forum, :user

  def to_param
    url
  end
end
