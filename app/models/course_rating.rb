class CourseRating
  attr_reader :rating

  def initialize(*args)
    options = args.extract_options!
    @opt_course = options.delete(:course)
    @opt_user = options.delete(:user)
    @rating = options.delete(:rating)
  end

  def course
    @course ||= @opt_course || rating.course
  end

  def user
    @user ||= @opt_user || rating.user
  end

  def user_rating
    @user_rating ||= Rating.where(user_id: user, course_id: course).first
  end

  def user_stars
    user_rating.try(:stars)
  end

  def stars_by_user_or_average
    user_stars || course_average
  end

  def course_average(cached = true)
    if cached
       course.rating_average
    else
      avg = course.ratings_sum.to_f / course.total_ratings.to_f
      avg.nan? ? 0.0 : avg
    end
  end
end
