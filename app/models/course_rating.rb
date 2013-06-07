class CourseRating
  attr_reader :rating

  def initialize(*args)
    options = args.extract_options!
    @opt_course = options.delete(:course)
    @opt_user = options.delete(:user)
    @opt_rating = options.delete(:rating)
  end

  def update_or_create_rating
    new_rating = Rating.find_or_initialize_by_course_id_and_user_id(course_id: rating[:course_id], user_id: user)
    new_rating.update_attribute :stars, rating[:stars]
  end

  def course
    @course ||= @opt_course || rating_course
  end

  def user
    @user ||= @opt_user || rating_user
  end

  def rating
    @rating ||= @opt_rating || user_rating
  end

  def rating_course
    rating.try(:course) if rating.is_a?(Rating)
  end

  def rating_user
    rating.try(:user) if rating.is_a?(User)
  end

  def user_rating
    @user_rating ||= Rating.where(user_id: user, course_id: course).first
  end

  def user_stars
    user_rating.try(:stars)
  end

  def stars_by_user_or_average
    user_stars || course.try(:rating_average)
  end
end
