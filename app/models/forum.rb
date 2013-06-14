class Forum < ActiveRecord::Base
  has_many :topics, class_name: 'ForumTopic', dependent: :destroy
  has_many :posts, class_name: 'ForumPost', through: :topics, dependent: :destroy
  belongs_to :course
  
  attr_accessible :description, :name, :url, :course

  acts_as_url :name

  def to_param
    url
  end
end
