class ForumGallery < ActiveRecord::Base
  belongs_to :post, class_name: 'ForumPost', touch: true
  has_many :images, :class_name => 'ForumImage', :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |a| a[:image].blank? }
end
