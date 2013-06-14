class Forum < ActiveRecord::Base
  has_many :topics,     :dependent => :destroy
  has_many :posts,      :through => :topics, :dependent => :destroy
  belongs_to :course
  
  attr_accessible :description, :name, :url, :course

  acts_as_url :name
end
