class Course < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :promotions, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :forums, dependent: :destroy

  scope :active, where(released: true)
  scope :preorder, where(released: false)

  mount_uploader :image, CourseImageUploader
  mount_uploader :hero_image, HeroImageUploader
  mount_uploader :video_image, VideoImageUploader
  mount_uploader :instructor_image, InstructorImageUploader

  attr_accessible :description, :image, :instructor_image, :instructor_name,
                  :instructor_description, :name, :price, :released, :start_date, :tagline,
                  :total_hours, :hero_image, :playlist_id, :instructor_title, :image_cache,
                  :hero_image_cache, :instructor_image_cache, :project_count, :document_count,
                  :video_image, :video_image_cache, :additional_description

  validates :name, presence: true
  validates :price, presence: true
  validates :start_date, presence: true

  acts_as_url :instructor_plus_course_name

  def has_student?(user)
    enrollments.purchased.where(user_id: user.id).exists?
  end

  def has_preordered_student?(user)
    enrollments.preordered.where(user_id: user.id).exists?
  end

  def price_in_cents
    Integer price * 100
  end

  def instructor_plus_course_name
    "#{instructor_name} #{name}"
  end

  def to_param
    url
  end

  def rated_by?(user)
    ratings.where(user_id: user.id).any?
  end

  def update_cached_average
    update_attribute :rating_average, rating_average(false)
  end

  def rating_average(cached = true)
    if cached
      read_attribute :rating_average
    else
      avg = ratings_sum.to_f / total_ratings.to_f
      avg.nan? ? 0.0 : avg
    end
  end

  def total_ratings
    ratings.size
  end

  def ratings_sum
    ratings.sum(:stars)
  end
end
