class ForemPost < ActiveRecord::Base
  belongs_to :forum_topic
  belongs_to :user
  belongs_to :reply_to, :class_name => "Post"

  has_many :replies, :class_name  => "Post",
                     :foreign_key => "reply_to_id",
                     :dependent   => :nullify

  validates :text, :presence => true

  attr_accessible :replied_to_id, :text
end
