class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :promotions
  has_many :ratings

  scope :active, where(released: true)

  attr_accessible :description, :image, :instructor_image, :instructor_name, :instructor_description, :name, :price, :released, :start_date

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
    Integer price*100
  end

  def instructor_plus_course_name
    "#{instructor_name} #{name}"
  end

  def to_param
    url
  end

  def total_ratings
    ratings.size
  end

  def ratings_sum
    ratings.sum(:stars)
  end

  def update_cached_average
    update_attribute :rating_average, rating_average(false)
  end

  def rating_average(cached = true)
    if cached
      read_attribute :rating_average
    else
      avg = self.ratings_sum.to_f / self.total_ratings.to_f
      avg.nan? ? 0.0 : avg
    end
  end
end
