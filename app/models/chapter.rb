class Chapter < ActiveRecord::Base
  belongs_to :course

  mount_uploader :image, ChapterImageUploader

  attr_accessible :description, :image, :name, :video_id, :course_id

  validates :name, presence: true
end
