class ForumTopic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many   :posts, class_name: 'ForumPost', dependent: :destroy, order: 'forum_posts.created_at ASC'
  has_many   :views, class_name: 'ForumView', as: :viewable

  scope :visible, -> { where(hidden: false) }
  scope :by_pinned_or_most_recent_post, -> { order('pinned DESC', 'last_post_at DESC') }

  accepts_nested_attributes_for :posts

  validates :subject, presence: true
  validates :user, presence: true

  before_save  :set_first_post_user

  acts_as_url :subject

  attr_accessible :hidden, :last_post_at, :locked, :pinned, :subject, :url, :views_count, :forum, :forum_id, :user, :posts_attributes

  def to_param
    url
  end

  def instructor_replies_count
    posts.joins(:user).where(users: { admin: true }).count
  end

  def register_view_by(user)
    return unless user

    view = views.find_or_create_by_user_id(user.id)
    view.increment!('count')
    increment!(:views_count)

    if view.current_viewed_at.nil?
      view.past_viewed_at = view.current_viewed_at = Time.now
    end

    # Update the current_viewed_at if it is BEFORE 15 minutes ago.
    if view.current_viewed_at < 15.minutes.ago
      view.past_viewed_at    = view.current_viewed_at
      view.current_viewed_at = Time.now
      view.save
    end
  end

  # Provide convenience methods for pinning, unpinning a topic
  def pin!
    update_attribute(:pinned, true)
  end

  def unpin!
    update_attribute(:pinned, false)
  end

  private

  def set_first_post_user
    if post = posts.first
      post.user = user
    end
  end
end
