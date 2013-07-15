class ForumImage < ActiveRecord::Base
  belongs_to :gallery, class_name: 'ForumGallery', touch: true

  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validates :forum_gallery_id, presence: true
  
  attr_accessible :image, :image_cache
end
