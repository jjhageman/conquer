class ForumPost < ActiveRecord::Base
  belongs_to :topic, class_name: 'ForumTopic', foreign_key: 'forum_topic_id'
  belongs_to :user
  belongs_to :reply_to, class_name: 'ForumPost'

  has_many :replies, class_name:   'ForumPost',
                     foreign_key:  'reply_to_id',
                     dependent:    :nullify

  validates :text, :presence => true

  attr_accessible :replied_to_id, :text, :user, :topic
end
