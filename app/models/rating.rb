class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  after_save :update_course_average_rating

  attr_accessible :stars, :course_id, :user_id

  validates :user_id, uniqueness: { scope: :course_id,
    message: "you have already rated this course" }

  def self.update_or_create_rating(*args)
    options = args.extract_options!
    stars = options.delete(:stars)
    new_rating = Rating.find_or_initialize_by_course_id_and_user_id(options)
    new_rating.update_attribute(:stars, stars) unless new_rating.stars == Float(stars)
    new_rating
  end

  def update_course_average_rating
    self.course.update_cached_average
  end
end
