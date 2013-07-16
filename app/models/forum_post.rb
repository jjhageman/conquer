class ForumPost < ActiveRecord::Base
  belongs_to :topic, class_name: 'ForumTopic', foreign_key: 'forum_topic_id'
  belongs_to :user
  belongs_to :reply_to, class_name: 'ForumPost'

  has_many :replies, class_name:   'ForumPost',
    foreign_key:  'reply_to_id',
    dependent:    :nullify
  has_many :images, :class_name => 'ForumImage', :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |a| a[:image].blank? }

  validates :text, :presence => true

  after_create :set_topic_last_post_at, :set_topic_instructor_replied
  after_destroy :set_topic_instructor_replied

  attr_accessible :replied_to_id, :text, :user, :topic, :forum_topic_id, :image_ids

  def self.by_created_at
    order :created_at
  end

  protected

  def set_topic_last_post_at
    topic.update_attribute(:last_post_at, created_at)
  end

  def set_topic_instructor_replied
    instructor_replied = topic.instructor_replies_count > 0
    topic.update_attribute(:instructor_replied, instructor_replied)
  end
end
