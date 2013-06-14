class ForumView < ActiveRecord::Base
  belongs_to :viewable, :polymorphic => true
  belongs_to :user

  validates :viewable_id, :viewable_type, :presence => true

  attr_accessible :user, :count, :current_viewed_at, :past_viewed_at, :viewable_id, :viewable_type
end
