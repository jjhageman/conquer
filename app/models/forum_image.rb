class ForumImage < ActiveRecord::Base
  belongs_to :post, class_name: 'ForumPost', touch: true

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  
  attr_accessible :image, :image_cache
end
